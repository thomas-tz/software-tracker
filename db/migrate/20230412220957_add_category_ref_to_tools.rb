class AddCategoryRefToTools < ActiveRecord::Migration[7.0]
  def change
    add_reference :tools, :category, foreign_key: true
  end
end
