class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:tools)
    @uncategorized_tools = Tool.uncategorized
    @tool_user_count = Tool.user_counts
  end

  def show
    @category = Category.includes(:tools).find(params[:id])
    @tools_not_in_category = Tool.not_in_category(@category)
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      redirect_to categories_path, alert: @category.errors.full_messages.to_s
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
