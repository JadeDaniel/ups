class RemoveItemIdFromVotes < ActiveRecord::Migration[6.0]
  def up
    remove_column :votes, :item_id
  end
end
