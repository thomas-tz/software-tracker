class ToolsController < ApplicationController
  def index
    @tools = Tool.includes(:category).all
  end

  def show
    @tool = Tool.includes(:users, :category).find(params[:id])
    @users_not_subscribed = User.not_subscribed(@tool)
  end

  def create
    @tool = Tool.new(tool_params)

    if @tool.save
      redirect_to tools_path, notice: 'New tool successfully created!'
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
      redirect_to @tool, notice: 'Tool successfully updated!'
    else
      redirect_to edit_tool_path(@tool), status: :unprocessable_entity, alert: @tool.errors.full_messages.to_s
    end
  end

  def destroy
    @tool = Tool.find(params[:id])
    @tool.destroy

    redirect_to tools_path, status: :see_other, notice: 'Tool successfully deleted!'
  end

  private
  def tool_params
    params
      .require(:tool)
      .permit(:name, :category_id)
      .transform_values { |value| value&.strip }
  end
end
