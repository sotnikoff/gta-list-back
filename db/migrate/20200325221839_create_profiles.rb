class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :r_star_id
      t.bigint :created_by

      t.timestamps
    end
  end
end
