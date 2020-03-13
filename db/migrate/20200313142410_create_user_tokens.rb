class CreateUserTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tokens do |t|
      t.references :user, foreign_key: false
      t.string :token
      t.datetime :expired_at

      t.timestamps
    end
    add_index(:user_tokens, :token)
  end
end
