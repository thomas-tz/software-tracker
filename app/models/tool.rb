class Tool < ApplicationRecord
  include PgSearch::Model
  multisearchable against: :name

  belongs_to :category, optional: true
  has_many :tool_users, counter_cache: :users_count
  has_many :users, through: :tool_users, dependent: :destroy

  validates :name, presence: true

  scope :uncategorized, -> { where.missing(:category) }
  scope :not_in_category, ->(category) { where.not(category:).or(Tool.where(category: nil)) }
  scope :not_subscribed, ->(user) { where.not(id: ToolUser.select(:tool_id).where(user:)) }
end
