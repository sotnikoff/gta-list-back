class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :email, :invited_by
end
