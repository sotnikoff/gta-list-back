class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :name, :r_star_id, :created_by
end
