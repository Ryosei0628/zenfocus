class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to posts_path,  success: t("users.create.success")
    else
      flash.now[:danger] =  t("users.create.failure")
      render :new, status: :unprocessable_entity
    end
  end

  def my_page
    @posts = current_user.post
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
