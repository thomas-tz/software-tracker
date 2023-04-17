class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      redirect_to users_path, alert: @user.errors.full_messages.to_s
    end
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
