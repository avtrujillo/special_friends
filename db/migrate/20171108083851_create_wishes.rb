class CreateWishes < ActiveRecord::Migration[5.1]
  def change
    create_table :wishes do |t|
      t.string    :title
      t.text      :description
      t.integer   :friend_id
      t.integer   :year
      t.integer   :intend_to_fulfill_id
      t.timestamps
    end
  end
end
