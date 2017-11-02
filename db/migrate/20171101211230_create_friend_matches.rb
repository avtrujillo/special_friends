class CreateFriendMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_matches do |t|
      t.integer :giver_id
      t.integer :recipient_id
      t.integer :year
    end
  end
end
