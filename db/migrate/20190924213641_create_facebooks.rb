class CreateFacebooks < ActiveRecord::Migration[5.1]
  def change
    create_table :facebooks do |t|
      t.string    :token
      t.datetime  :token_expiration
      t.string    :link
      t.string    :email
      t.timestamps
    end

  end
end
