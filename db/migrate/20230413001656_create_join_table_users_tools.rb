class CreateJoinTableUsersTools < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :tools do |t|
      # t.index [:user_id, :tool_id]
      # t.index [:tool_id, :user_id]
    end
  end
end
