class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.string  :name
      t.integer :generation_id
      t.timestamps
    end
  end
end
