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
      # @tools = Tool.all
      # render :index, status: :unprocessable_entity
      redirect_to tools_path, alert: @tool.errors.full_messages.to_s

    end
  end

  private
  def tool_params
    params.require(:tool).permit(:name, :category_id)
  end
end
