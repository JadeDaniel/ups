class AddContestToVotes < ActiveRecord::Migration[6.0]
  def up
    add_reference :votes, :contest, foreign_key: true
    change_column_null :votes, :contest_id, false
  end

  def down
    remove_column :votes, :contest_id
  end
end
