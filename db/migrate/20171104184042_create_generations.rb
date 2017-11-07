class CreateGenerations < ActiveRecord::Migration[5.1]
  def change
    create_table :generations do |t|
      t.string  :name
    end
  end
end
