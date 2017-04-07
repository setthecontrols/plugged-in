class BoardcategoriesController < ApplicationController
  def index
    @categories = Boardcategory.all
  end
end
