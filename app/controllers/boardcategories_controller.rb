class BoardcategoriesController < ApplicationController
  def index
    @categories = Boardcategory.order(:name).page params[:page]
  end
end
