class Tool < ApplicationRecord
  include PgSearch::Model
  multisearchable against: :name

  belongs_to :category, optional: true
  has_many :tool_users
  has_many :users, through: :tool_users, dependent: :destroy

  validates :name, presence: true

  scope :uncategorized, -> { where category: nil }
  scope :not_in_category, -> (category) {  where.not(category_id: category.id).or(Tool.where(category_id: nil)) }
  scope :not_subscribed, -> (user) { where.not(id: ToolUser.select(:tool_id).where(user_id: user.id)) }

  def self.user_counts
    Tool.joins(:tool_users).group(:tool_id).count
  end
end
