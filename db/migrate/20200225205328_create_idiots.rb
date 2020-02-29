class CreateIdiots < ActiveRecord::Migration[6.0]
  def change
    create_table :idiots do |t|
      t.string :name
      t.datetime :death_date
      t.integer :r_star_id
      t.text :pazient_diagnos
      t.text :comment
      t.boolean :agressive
      t.integer :mom_joke

      t.timestamps
    end
  end
end
