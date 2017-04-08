class SearchesController < ApplicationController
  def index
    @none = false
    @keyword = params[:keyword]
    @search = Search.new
    @results = @search.find(@keyword)
    if @results[:posts].none? && @results[:categories].none?
      @none = true
    end
  end
end
