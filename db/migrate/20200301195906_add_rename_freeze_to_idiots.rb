class AddRenameFreezeToIdiots < ActiveRecord::Migration[6.0]
  def change
    rename_column :idiots, :freeze, :freeze_player
  end
end
