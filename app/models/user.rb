class User < ApplicationRecord
  has_many :tool_users
  has_many :tools, through: :tool_users, dependent: :destroy

  validates :first_name, :last_name, presence: true

  scope :not_subscribed, -> (tool) { where.not(id: ToolUser.select(:user_id).where(tool_id: tool.id)) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.tool_counts
    User.joins(:tool_users).group(:user_id).count
  end
end
