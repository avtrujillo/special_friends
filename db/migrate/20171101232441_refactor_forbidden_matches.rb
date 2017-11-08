class CreateForbiddenMatches < ActiveRecord::Migration[5.1]
  def change
    create_table  :forbidden_matches do |t|
      t.integer :friend_1_id
      t.integer :friend_2_id
      t.timestamps
    end
  end
end
