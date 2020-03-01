class AddChangeCheaterToIdiots < ActiveRecord::Migration[6.0]
  def change
    change_column :idiots, :mom_joke, :integer, default: 0
    remove_column :idiots, :is_cheater
    add_column :idiots, :cheats, :integer, default: 0
  end
end
