class LocationsController < ApplicationController
  def index
    @locations = Location.order('created_at DESC')
  end

  def new
    @location = Location.new
  end

  def show
    @location = Location.find(params[:id])
    @user = User.find(@location.user_id)
  end

  def create
    @user = User.find(current_user.id)
    @location = Location.new(location_params)
    @location.user_id = @user.id
    if @location.save
      flash[:success] = "Location added!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def location_params
    params.require(:location).permit(:title, :address)
  end
end
