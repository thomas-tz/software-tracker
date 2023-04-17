class ToolUsersController < ApplicationController
  def create
    tool_user = ToolUser.new
    tool_user.tool_id = params[:tool]
    tool_user.user_id = params[:user]

    if tool_user.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: tool.errors.full_messages.to_s
    end
  end

  def destroy
    tool_user = ToolUser.find(params[:id])
    tool_user.destroy
    redirect_to request.referer
  end
end
