class BoardpostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_post, only: [:show, :edit, :delete, :update]
  before_action :find_cat_through_post, except: [:new, :create]

  def show
    @author = User.find(@post.user_id)
  end

  def new
    @post = Boardpost.new
    if !user_signed_in?
      redirect_to new_user_session_path
    end

  end

  def create
    @category = Boardcategory.find_by(name: params[:boardcategory][:name])
    @post = Boardpost.new(post_params)
    @post.user_id = current_user.id
    @post.boardcategory_id = @category.id
    if @post.save
      redirect_to boardcategories_path
    else
      @errors = @post.errors.full_messages
      render :new
    end
  end

  def edit
    redirect_to '/' if current_user.id != @post.user_id
    # throw error?
  end

  def update
    @post.update_attributes(post_params)
  end

  def delete
    if current_user.id == @post.user_id
      @post.destroy
    end
    redirect_to '/boardcategories'
    # make it go to a success page?
  end

  private
    def post_params
      params.require(:boardpost).permit(:title, :content)
    end

    def find_post
      @post = Boardpost.find(params[:id])
    end


    def find_cat_through_post
      @category = Boardcategory.find(@post.boardcategory_id)
    end
end
