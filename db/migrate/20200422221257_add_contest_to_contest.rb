class AddContestToContest < ActiveRecord::Migration[6.0]
  def change
    add_column :contests, :parent_id, :integer, foreign_key: true
  end
end
