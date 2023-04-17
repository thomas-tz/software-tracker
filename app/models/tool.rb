class Tool < ApplicationRecord
  belongs_to :category
  has_many :tool_users
  has_many :users, through: :tool_users

  validates :name, presence: true
  validates :category_id, presence: true
end
