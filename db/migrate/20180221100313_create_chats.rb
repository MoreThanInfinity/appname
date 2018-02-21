class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.string :identifier
      t.string :name
      t.string :type
    end
  end
end
