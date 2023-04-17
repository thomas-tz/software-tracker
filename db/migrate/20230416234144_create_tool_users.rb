class CreateToolUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :tool_users do |t|
      t.belongs_to :tool
      t.belongs_to :user
      t.timestamps
    end
  end
end
