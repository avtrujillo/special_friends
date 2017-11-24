class AddSentToFriendMessage < ActiveRecord::Migration[5.1]
  def change
    change_table :friend_messages do |t|
      t.boolean :sent
    end
  end
end
