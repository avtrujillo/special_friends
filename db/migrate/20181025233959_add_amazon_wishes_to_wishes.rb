class AddAmazonWishesToWishes < ActiveRecord::Migration[5.1]
  def change

    change_table :wishes do |t|
      t.integer   :friend_amazon_wish_id
    end

  end
end
