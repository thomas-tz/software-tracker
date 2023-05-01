class AddToolsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tools_count, :integer, default: 0, null: false
  end
end
