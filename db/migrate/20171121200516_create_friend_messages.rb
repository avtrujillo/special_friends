class CreateFriendMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_messages do |t|
      t.integer :friend_match_id
      t.integer :sender_id
      t.integer :recipient_id
      t.text    :content
      t.boolean :read?

      t.timestamps
    end
  end
end
