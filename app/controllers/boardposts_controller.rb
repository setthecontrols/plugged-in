class BoardpostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :delete, :update]
  def index
    @posts = Index.where(category_id: params[:id]).order_by(created_at, DESC)
  end

  def show
  end

  def new
  end

  def create
    @post = Boardpost.new(post_params)
    @post.user_id = current_user.id
  end

  def edit
  end

  def update
    @post.update_attributes(post_params)
  end

  def delete
    @post.destroy
    redirect_to '/'
    # make it go to a success page?
  end

  private
    def post_params
      params.require(:boardpost).permit(:title, :content)
    end

    def find_post
      @post = Boardpost.find(params[:post_id])
    end
end
