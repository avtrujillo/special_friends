class CreateFriendAmazonLists < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_amazon_lists do |t|

      t.string  :external_id, null: false
      t.integer :friend_id, null: false
      t.integer :year, null: false

      t.timestamps
    end
  end
end
