class AddGeoToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :city, :string
    add_column :idiots, :country, :string
  end
end
