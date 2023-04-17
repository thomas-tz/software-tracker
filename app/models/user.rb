class User < ApplicationRecord
  has_many :tool_users
  has_many :tools, through: :tool_users

  validates :name, presence: true
end
