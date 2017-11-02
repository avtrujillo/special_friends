class RefactorForbiddenMatch < ActiveRecord::Migration[5.1]
  def change
    drop_table    :forbidden_matches
    create_table  :forbidden_matches do |t|
      t.integer :friend_1_id
      t.integer :friend_2_id
    end
  end
end
