class CleanUpContestAndVote < ActiveRecord::Migration[6.0]
  def up
    remove_column :votes, :item_id
    remove_column :contests, :contest_id

    rename_column :contests, :body, :note
    rename_column :contests, :title, :name
  end

  def down
    rename_column :contests, :note, :body
    rename_column :contests, :name, :title
  end

end
