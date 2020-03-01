class AddAutoKickToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :auto_kick, :boolean, default: false
  end
end
