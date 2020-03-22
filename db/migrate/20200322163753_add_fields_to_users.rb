class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :invitation_token, :string
    add_column :users, :invited_by, :bigint
    add_column :users, :email, :string
  end
end
