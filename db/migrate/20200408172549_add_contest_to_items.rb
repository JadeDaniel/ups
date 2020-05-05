class AddContestToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :contest_id, :integer
    add_index :items, :contest_id
  end
end
