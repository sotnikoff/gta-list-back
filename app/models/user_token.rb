class UserToken < ApplicationRecord
  belongs_to :user

  validates :token, :expired_at, presence: true

  def self.user_by_token(token)
    parsed_token = parse_token(token)
    decoded_token = JWT.decode(parsed_token, 'my$ecretK3y', true, algorithm: 'HS256')
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
end
