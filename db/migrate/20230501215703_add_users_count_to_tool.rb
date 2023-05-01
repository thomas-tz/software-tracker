class AddUsersCountToTool < ActiveRecord::Migration[7.0]
  def change
    add_column :tools, :users_count, :integer, default: 0, null: false
  end
end
