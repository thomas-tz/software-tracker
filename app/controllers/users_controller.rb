class UsersController < ApplicationController
  def index
    @users = User.all
    @tool_count = User.tool_counts
  end

  def show
    @user = User.includes(:tools).find(params[:id])
    @tools_not_subscribed = Tool.not_subscribed(@user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      redirect_to users_path, status: :unprocessable_entity, alert: @user.errors.full_messages.to_s
    end
  end

  def edit
    @user = User.includes(:tools).find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      redirect_to edit_user_path(@user), status: :unprocessable_entity, alert: @user.errors.full_messages.to_s
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path, status: :see_other
  end

  private
  def user_params
    params
      .require(:user)
      .permit(:first_name, :last_name)
      .each_value { |value| value.try(:strip!) }
  end
end
