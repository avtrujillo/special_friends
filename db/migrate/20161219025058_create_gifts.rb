class CreateGifts < ActiveRecord::Migration[5.0]
  def change
    create_table  :gifts do |t|
      t.string    :title
      t.text      :description
      t.integer   :wish_id
      t.integer   :giver_id
      t.integer   :recipient_id
      t.text      :purchase_status
      #t.date      :shipped
      #t.text      :shipping_details
      #t.date      :received
      t.integer   :year
      t.timestamps
    end
  end
end
