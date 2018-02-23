class RemoveConfirmableleFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, :confirmation_token
    remove_column :users, :confirmation_token, :string
    remove_column :users, :confirmed_at, :datetime
    remove_column :users, :confirmation_sent_at, :datetime
    remove_column :users, :unconfirmed_email, :string

  end
end
