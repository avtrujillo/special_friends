class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.integer :id
      t.string :name
      t.string :wish_list
      t.string :forbidden_match
      t.string :giver
      t.string :recipient
      t.boolean :millenial?

      t.timestamps
    end
  end
end
