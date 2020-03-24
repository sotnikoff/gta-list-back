class AddGeo2ToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :region, :string
    add_column :idiots, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :idiots, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
