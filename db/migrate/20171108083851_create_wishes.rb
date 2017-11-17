class CreateWishes < ActiveRecord::Migration[5.1]
  def change
    create_table :wishes do |t|
      t.string    :title
      t.text      :description
      t.integer   :friend_id
      t.integer   :year
      t.timestamps
    end
  end
end
