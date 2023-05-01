class CacheToolsUsersCounts < ActiveRecord::Migration[7.0]
  def change
    Tool.all.each do |tool|
      users_count = ToolUser.where(tool: tool).size
      Tool.update_counters(tool.id, users_count: users_count)
    end

    User.all.each do |user|
      tools_count = ToolUser.where(user: user).size
      User.update_counters(user.id, tools_count: tools_count)
    end
  end
end
