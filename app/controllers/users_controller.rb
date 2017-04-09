class UsersController < ApplicationController

  def show
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
   end
end
