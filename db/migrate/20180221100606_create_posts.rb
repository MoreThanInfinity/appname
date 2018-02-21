class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :attachments
      t.string :post_pict
      t.references :user, foreign_key: true
    end
  end
end
