class RefactorGifts < ActiveRecord::Migration[5.1]
  def change
    change_table :gifts do |t|
      t.remove  :asked_for, :intend_to_give, :description
      t.text    :description
      t.integer :wish_id
      t.integer :giver_id
      t.integer :recipient_id
      t.boolean :intend_to_give
      t.remove  :shipping_details
      t.text    :shipping_details
      t.integer :year
    end
  end
end
