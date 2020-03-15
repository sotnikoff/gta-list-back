class AddCreatedByToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :created_by, :bigint
  end
end
