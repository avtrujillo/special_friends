class CreateRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipients do |t|

      t.timestamps
    end
  end
end
