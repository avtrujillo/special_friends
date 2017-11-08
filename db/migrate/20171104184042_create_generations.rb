class CreateGenerations < ActiveRecord::Migration[5.1]
  def change
    create_table :generations do |t|
      t.string  :name
      t.timestamps
    end
  end
end
