class AddTimestampsToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :created_at, :datetime, null: false, default: 'NOW()'
    add_column :messages, :updated_at, :datetime, null: false, default: 'NOW()'
  end
end
