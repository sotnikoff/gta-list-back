class AddDefaultValToIdiots < ActiveRecord::Migration[6.0]
  def change
    change_column :idiots, :agressive, :boolean, default: false
  end
end
