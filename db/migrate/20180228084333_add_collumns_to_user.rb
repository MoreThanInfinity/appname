class AddCollumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hobbies, :string
    add_column :users, :city, :string
    add_column :users, :available_languages, :string
    add_column :users, :education, :string
    add_column :users, :phone_number, :string
    add_column :users, :date_of_birth, :date
  end
end
