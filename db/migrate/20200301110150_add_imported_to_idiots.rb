class AddImportedToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :imported, :boolean, default: false
  end
end
