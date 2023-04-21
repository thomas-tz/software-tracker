class ToolsController < ApplicationController
  def index
    @tools = Tool.includes(:category).all
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

  def edit
    @tool = Tool.includes(:users, :category).find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])

    if @tool.update(tool_params)
      redirect_to @tool
    else
      redirect_to edit_tool_path(@tool), status: :unprocessable_entity, alert: @tool.errors.full_messages.to_s
    end
  end

  def destroy
    @tool = Tool.find(params[:id])
    @tool.destroy

    redirect_to tools_path, status: :see_other
  end

  private
  def tool_params
    params
      .require(:tool)
      .permit(:name, :category_id)
      .each_value { |value| value.try(:strip!) }
  end
end
