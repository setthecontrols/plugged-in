class UsersController < ApplicationController

  def index
    @locations = Location.near([current_user.latitude, current_user.longitude], 10)
    @users = User.all
  end

  def feed
    @user = current_user
    @feed = @user.all_feeds
    @posts = Boardpost.all
    @categories = Boardcategory.all
    @users = User.all

    p '*'* 80
    p "we're peeing out @users!!"
    p @users

   end

  def show
    @user = User.find(current_user.id)
    @locations = Location.where(user_id: current_user.id)
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
  def update_user_audio_files_params
    params.require(:audio).permit(:file)
  end
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
