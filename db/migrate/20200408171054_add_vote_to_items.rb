class AddVoteToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :item_id, :integer
    add_index :votes, :item_id
  end
end