class User << ApplicationController

  def index
    # finish after musician search functionality added
  end


  def show
     @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login
      flash.notice = "Thanks for registering '#{@user.username}'!!!!"
      redirect_to @user
    else
      flash.notice = "We were unable to sign you up... please try again."
      redirect_to '/users/new'
    end
  end

  def edit
  end

  def update
    @user = User.update_attributes(:user)
  end

  def user_params
   params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end
end
