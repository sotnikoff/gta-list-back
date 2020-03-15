class CreateMamkenSchutkens < ActiveRecord::Migration[6.0]
  def change
    create_table :mamken_schutkens do |t|
      t.references :user, null: false, foreign_key: false
      t.references :idiot, null: false, foreign_key: false
      t.text :message

      t.timestamps
    end
  end
end
