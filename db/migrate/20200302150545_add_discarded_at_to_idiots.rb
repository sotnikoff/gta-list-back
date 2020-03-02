class AddDiscardedAtToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :discarded_at, :datetime
    add_index :idiots, :discarded_at
  end
end
