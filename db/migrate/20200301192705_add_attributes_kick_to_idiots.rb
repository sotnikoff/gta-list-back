class AddAttributesKickToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :warn_me, :boolean, default: false
    add_column :idiots, :freeze, :boolean, default: false
    add_column :idiots, :blame, :boolean, default: false
    add_column :idiots, :explode, :boolean, default: false
  end
end
