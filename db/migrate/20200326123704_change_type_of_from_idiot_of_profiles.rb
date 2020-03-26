class ChangeTypeOfFromIdiotOfProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :from_idiot
    add_column :profiles, :idiot_id, :bigint
  end
end
