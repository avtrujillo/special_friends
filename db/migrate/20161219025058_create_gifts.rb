class CreateGifts < ActiveRecord::Migration[5.0]
  def change
    create_table  :gifts do |t|
      t.string    :title
      t.string    :description
      t.boolean   :asked_for
      t.string    :giver
      t.string    :recipient
      t.string    :intend_to_give
      t.date      :shipped
      t.string    :shipping_details
      t.date      :recieved

      t.timestamps
    end
  end
end
