class AddTokenTypeToUserTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :user_tokens, :token_type, :integer, default: 0
  end
end
