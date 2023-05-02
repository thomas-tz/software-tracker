class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(tools: :users)
    @uncategorized_tools = Tool.includes(:users).uncategorized
  end

  def show
    @category = Category.includes(tools: :users).find(params[:id])
    @tools_not_in_category = Tool.not_in_category(@category)
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'New category successfully created!'
    else
      redirect_to categories_path, status: :unprocessable_entity, alert: @category.errors.full_messages.to_s
    end
  end

  def edit
    @category = Category.includes(tools: :users).find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to @category, notice: 'Category successfully updated!'
    else
      redirect_to edit_category_path(@category), status: :unprocessable_entity, alert: @category.errors.full_messages.to_s
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path, status: :see_other, notice: 'Category successfully deleted!'
  end

  private

  def category_params
    params
      .require(:category)
      .permit(:name)
      .transform_values { |value| value&.strip }
  end
end
