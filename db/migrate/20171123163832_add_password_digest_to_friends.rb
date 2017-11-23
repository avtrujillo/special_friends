class AddPasswordDigestToFriends < ActiveRecord::Migration[5.1]
  def change
    change_table :friends do |t|
      t.string :password_digest
    end
  end
end
