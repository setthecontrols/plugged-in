class BoardcategoriesController < ApplicationController
  def index
    @categories = Boardcategory.order(:name).page params[:page]
  end

  def show
    @category = Boardcategory.find(params[:id])
    @posts = @category.boardposts.page params[:page]
  end
end
