class DropToolsUsers < ActiveRecord::Migration[7.0]
  def change
    drop_join_table :tools, :users
  end
end
