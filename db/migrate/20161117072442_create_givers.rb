class CreateGivers < ActiveRecord::Migration[5.0]
  def change
    create_table :givers do |t|

      t.timestamps
    end
  end
end
