class MamkenSchutkenSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :idiot_id, :message, :created_at, :updated_at
end
