class RefactorForbiddenMatches < ActiveRecord::Migration[5.1]
  def change
    change_table  :forbidden_matches do |t|
      t.integer :friend_1_id
      t.integer :friend_2_id
    end
  end
end
