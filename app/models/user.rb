class User < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:first_name, :last_name]

  has_many :tool_users, counter_cache: :tools_count
  has_many :tools, through: :tool_users, dependent: :destroy

  validates :first_name, :last_name, presence: true

  scope :not_subscribed, -> (tool) { where.not(id: ToolUser.select(:user_id).where(tool: tool)) }

  def name
    "#{first_name} #{last_name}"
  end
end
