class DropYears < ActiveRecord::Migration[5.1]
  def change
    drop_table  :years
    drop_table  :lists
    drop_table  :recipients
    drop_table  :givers
    drop_table  :matchlists
    drop_table  :friendlists
    drop_table  :matches
  end
end
