class AddEmailToFriends < ActiveRecord::Migration[5.1]
  def change
    change_table :friends do |t|
      t.string :email
    end
  end
end
