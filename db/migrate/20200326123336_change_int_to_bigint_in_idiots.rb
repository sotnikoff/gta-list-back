class ChangeIntToBigintInIdiots < ActiveRecord::Migration[6.0]
  def change
    change_column :idiots, :r_star_id, :bigint
  end
end
