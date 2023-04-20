class User < ApplicationRecord
  has_many :tool_users
  has_many :tools, through: :tool_users

  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :not_subscribed, -> (tool) { where.not(id: ToolUser.select(:user_id).where(tool_id: tool.id)) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
