class CreateForbiddenMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :forbidden_matches do |t|

      t.timestamps
    end
  end
end
