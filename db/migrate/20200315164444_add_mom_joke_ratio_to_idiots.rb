class AddMomJokeRatioToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :mom_joke_ratio, :integer, default: 0
  end
end
