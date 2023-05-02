class ToolUsersController < ApplicationController
  def create
    tool_user = ToolUser.new(tool_user_params)

    if tool_user.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: tool_user.errors.full_messages.to_s
    end
  end

  def destroy
    ToolUser.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def tool_user_params
    params.require(:tool_user).permit(:user_id, :tool_id)
  end
end
