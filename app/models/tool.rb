class Tool < ApplicationRecord
  belongs_to :category, optional: true
  has_many :tool_users
  has_many :users, through: :tool_users

  validates :name, presence: true

  scope :uncategorized, -> { where category: nil }
  scope :not_in_category, -> (category) {  where.not(category_id: category.id).or(Tool.where(category_id: nil)) }
  scope :not_subscribed, -> (user) { where.not(id: ToolUser.select(:tool_id).where(user_id: user.id)) }
end
