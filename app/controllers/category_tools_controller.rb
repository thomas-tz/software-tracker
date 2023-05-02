class CategoryToolsController < ApplicationController
  def create
    tool = Tool.find(params[:id])
    tool.category_id = params[:category_id]

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
