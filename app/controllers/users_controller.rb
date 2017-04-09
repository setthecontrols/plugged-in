class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    p current_user
    p "*"*45
    p @user
  end

  def edit
    @user = current_user
    # super
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
   end
end
