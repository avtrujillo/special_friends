class RefactorFriends < ActiveRecord::Migration[5.1]
  def change
    change_table :friends do |t|
      t.integer :generation_id
      t.remove  :millenial
      t.remove  :wish_list
      t.remove  :forbidden_match
      t.remove  :giver
      t.remove  :recipient
    end
  end
end
