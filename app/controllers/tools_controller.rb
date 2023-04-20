class ToolsController < ApplicationController
  def index
    @tools = Tool.all
    @user_count = Tool.user_counts

  end

  def show
    @tool = Tool.includes(:users, :category).find(params[:id])
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

  def destroy
    @tool = Tool.find(params[:id])
    @tool.destroy

    redirect_to tools_path, status: :see_other
  end

  private
  def tool_params
    params.require(:tool).permit(:name, :category_id)
  end
end
