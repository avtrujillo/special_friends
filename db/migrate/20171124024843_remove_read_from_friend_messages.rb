class RemoveReadFromFriendMessages < ActiveRecord::Migration[5.1]
  def change
    remove_column :friend_messages, :read?
    change_table :friend_messages do |t|
      t.boolean :read
    end
  end
end
