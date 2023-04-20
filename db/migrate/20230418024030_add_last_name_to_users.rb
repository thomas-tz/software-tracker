class AddLastNameToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.rename :name, :first_name
      t.column :last_name, :string
    end
  end
end
