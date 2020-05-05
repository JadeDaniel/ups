class AddBodyToContest < ActiveRecord::Migration[6.0]
  def change
    add_column :contests, :body, :text
  end
end
