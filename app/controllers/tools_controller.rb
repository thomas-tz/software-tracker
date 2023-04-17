class ToolsController < ApplicationController
  def index
    @tools = Tool.all
  end

  def show
    @tool = Tool.find(params[:id])
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
      redirect_to @tool
    else
      redirect_to @tool, alert: @tool.errors.full_messages.to_s
    end
  end

  private
  def tool_params
    params.require(:tool).permit(:name, :category_id)
  end
end
