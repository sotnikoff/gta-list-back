class User < ApplicationRecord
  include BCrypt

  has_many :user_tokens, dependent: :destroy
  belongs_to :inviter, class_name: 'User', foreign_key: :invited_by, optional: true

  validates :nickname, presence: true, if: :not_invited?
  validates :nickname, uniqueness: true, if: :not_invited?
  validates :email, presence: true
  validates :email, uniqueness: true

  attr_accessor :password, :password_confirmation

  before_validation :calculate_password, if: :not_invited?

  scope :invited, lambda { |params|
    return where.not(invited_by: nil) if params[:invited].present? && params[:invited] != 'false'

    all
  }

  def create_token
    exp = Time.current + 10.days
    token = JWT.encode({ data: { id: id, nickname: nickname }, exp: exp.to_i }, Rails.application.credentials[:auth_key], 'HS256')
    user_tokens << UserToken.new(
      token: token,
      expired_at: exp
    )
    { token: token, expired: exp.to_i, user_id: id }
  end

  def destroy_token(token)
    user_tokens.find_by(token: token)&.destroy
  end

  def authenticate(password)
    Password.new(password_digest) == password
  end

  def self.by_filter(params)
    invited(params)
  end

  def self.invite(inv_email, current_user)
    url = Rails.application.credentials.public_send(Rails.env.to_sym)[:front_address]
    exp = Time.current + 30.days
    token = JWT.encode({ data: { email: inv_email }, exp: exp.to_i }, Rails.application.credentials[:auth_key], 'HS256')
    user = User.create(email: inv_email, invitation_token: token, inviter: current_user)
    InvitesMailer.invite(user, url).deliver_now if user.valid?
    user
  end

  private

  def calculate_password
    errors.add(:password, 'password blank') if password.nil?
    errors.add(:password_confirmation, 'passwords dont match') if password != password_confirmation

    self.password_digest = Password.create(password)
  end

  def not_invited?
    invitation_token.nil?
  end
end
