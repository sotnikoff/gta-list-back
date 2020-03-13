class User < ApplicationRecord
  has_secure_password

  has_many :user_tokens, dependent: :destroy

  validates :nickname, presence: true
  validates :nickname, uniqueness: true
  validates :password, :password_confirmation, presence: true, on: :create

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
end
