class AndCompletedToContests < ActiveRecord::Migration[6.0]
  def change
    add_column :contests, :completed, :boolean
  end
end
