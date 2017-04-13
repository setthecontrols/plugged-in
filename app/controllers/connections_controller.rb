class ConnectionsController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @connected_users = @user.connected_users
    @possible_connections = @user.possible_connections
  end

  def new
    @connection = Connection.new
  end

  def create
    @logged_in_user = current_user
    @user = User.find(params[:user_id])

     @logged_in_user.connected_users <<  @user
     redirect_to user_path(@user)
  end

  def delete
    @logged_in_user = current_user
    @user = User.find(params[:id])
    connect = Connection.find_by(user_id: current_user.id, connected_user_id: @user.id)
    connect.destroy
    redirect_to user_path(@user)


  end

end
