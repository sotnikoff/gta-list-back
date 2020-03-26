class Profile < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :created_by
  belongs_to :parent, class_name: 'Idiot', foreign_key: :idiot_id, optional: true

  validates :name, presence: true
  validates :r_star_id, presence: true

  validates :name, uniqueness: true
  validates :r_star_id, uniqueness: true
end
