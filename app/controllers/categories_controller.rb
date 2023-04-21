class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:tools)
    @uncategorized_tools = Tool.uncategorized
    @tool_user_count = Tool.user_counts
  end

  def show
    @category = Category.includes(:tools).find(params[:id])
    @tools_not_in_category = Tool.not_in_category(@category)
    @tool_user_count = Tool.user_counts
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      redirect_to categories_path, alert: @category.errors.full_messages.to_s
    end
  end

  def edit
    @category = Category.includes(:tools).find(params[:id])
    @tool_user_count = Tool.user_counts
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to @category
    else
      redirect_to edit_category_path(@category), status: :unprocessable_entity, alert: @category.errors.full_messages.to_s
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path, status: :see_other
  end

  private
  def category_params
    params
      .require(:category)
      .permit(:name)
      .each_value { |value| value.try(:strip!) }
  end
end
