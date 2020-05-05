class AddItemToVotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :item, foreign_key: true
  end
end
