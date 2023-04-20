class CategoryToolsController < ApplicationController
  def update
    tool = Tool.find(params[:tool_id])
    tool.category_id = params[:id]

    if tool.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: tool.errors.full_messages.to_s
    end
  end

  def destroy
    tool = Tool.find(params[:id])
    tool.category_id = nil

    if tool.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: tool.errors.full_messages.to_s
    end
  end
end
