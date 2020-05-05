class AddDeleteCascadeToItem < ActiveRecord::Migration[6.0]
  def up
    remove_reference :votes, :item
    add_reference :votes, :item, foreign_key: {on_delete: :cascade}
  end

  def down
    remove_reference :votes, :item
    add_reference :votes, :item, foreign_key: true
  end

end
