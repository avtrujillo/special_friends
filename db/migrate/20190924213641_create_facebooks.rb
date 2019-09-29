class CreateFacebooks < ActiveRecord::Migration[5.1]
  def change
    create_table :facebooks do |t|
      t.string    :token
      t.datetime  :token_expiration
      t.string    :link
      t.string    :email
      t.integer   :friend_id
      t.timestamps
    end

    add_foreign_key :facebooks, :friends

  end
end
