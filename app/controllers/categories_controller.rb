class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @uncategorized_tools = Tool.uncategorized
  end

  def show
    @category = Category.find(params[:id])
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
