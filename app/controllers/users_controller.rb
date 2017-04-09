class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # @user = User.find(current_user.id)

  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_user_params)
      bypass_sign_in(@user)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end
  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :bio, :location, :band_status, :experience, :instruments, :slogan)
  end
end
