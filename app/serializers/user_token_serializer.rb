class UserTokenSerializer < ActiveModel::Serializer
  attributes :id, :token, :created_at, :expired_at
end
