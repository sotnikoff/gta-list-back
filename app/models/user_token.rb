class UserToken < ApplicationRecord
  belongs_to :user

  enum token_type: { user_token: 0, api_token: 1 }

  validates :token, :expired_at, presence: true

  scope :api_tokens, lambda { |user|
    where(token_type: 1, user: user)
  }

  def self.user_by_token(token)
    parsed_token = parse_token(token)
    decoded_token = JWT.decode(parsed_token, Rails.application.credentials[:auth_key], true, algorithm: 'HS256')
    user_id = decoded_token.try(:[], 0).try(:[], 'data').try(:[], 'id')
    user = User.find_by(id: user_id)
    return if user.blank? || user.user_tokens.find_by(token: parsed_token).blank?

    user
  rescue JWT::ImmatureSignature
    nil
  rescue JWT::DecodeError
    nil
  end

  def self.parse_token(token)
    return nil if token.nil?

    token.scan(/^Bearer (.+\..+)$/).flatten.try(:[], 0)
  end

  def self.create_api_token(user)
    exp = Time.current + 365.days
    token = JWT.encode({ data: { id: user.id, nickname: user.nickname }, exp: exp.to_i }, Rails.application.credentials[:auth_key], 'HS256')
    UserToken.create(
      token: token,
      expired_at: exp,
      token_type: :api_token,
      user: user
    )
  end
end
