class SearchesController < ApplicationController
  def index
    @keyword = params[:keyword]
    @results = search(@keyword)
    @found = any_results?(@results)
  end
end
