class ToolUser < ApplicationRecord
  belongs_to :tool, counter_cache: :users_count
  belongs_to :user, counter_cache: :tools_count
end
