class AddIsCheaterFieldToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :is_cheater, :boolean, default: false
  end
end
