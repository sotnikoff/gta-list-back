class AddDraftToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :draft, :boolean, default: false
  end
end
