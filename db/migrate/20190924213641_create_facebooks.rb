class CreateFacebooks < ActiveRecord::Migration[5.1]
  def change
    create_table :facebooks do |t|
      t.timestamps
    end

    change_table :friends do |t|
      # t.integer :facebook_id
    end
  end
end
