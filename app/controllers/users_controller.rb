class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @locations = Location.where(user_id: params[:id])
    @location = @locations.last
  end

  def edit
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
      if @user.update(password_params)
        bypass_sign_in(@user)
        redirect_to root_path
      else
        render "edit"
      end
  end

  def update
    p "*"*30
    p update_user_params
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
    params.require(:user).permit(:first_name, :last_name, :email, :username, :bio, :location, :band_status, :experience, :instruments, :slogan, :avatar, :audio_file_content_type)
  end
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
