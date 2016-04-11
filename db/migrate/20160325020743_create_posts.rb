class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_message
      t.references :review, index: true

      t.timestamps null: false
    end
    add_foreign_key :posts, :reviews
  end
end
