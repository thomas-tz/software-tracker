class ToolsController < ApplicationController
  def index
    @tools = Tool.all
    @user_count = Tool.joins(:tool_users).group(:tool_id).count

  end

  def show
    @tool = Tool.includes(:users).find(params[:id])
    @users_not_subscribed = User.not_subscribed(@tool)
  end

  def create
    @tool = Tool.new(tool_params)

    if @tool.save
      redirect_to tools_path
    else
      redirect_to tools_path, alert: @tool.errors.full_messages.to_s
    end
  end

  def update
    @tool = Tool.find(params[:id])

    if @tool.update(tool_params)
      redirect_to tool_path
    else
      redirect_to tool_path, alert: @tool.errors.full_messages.to_s
    end
  end

  private
  def tool_params
    params.require(:tool).permit(:name, :category_id)
  end
end
