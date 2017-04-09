class SearchesController < ApplicationController
  def index
    @keyword = params[:keyword].downcase
    @results = search_all(@keyword)
    @found = any_results_all?(@results)
  end

  def advanced_form
  end

  def advanced
    @keyword = params[:keyword].downcase
    @model = params[:model].downcase
    @results = search_specific(@keyword, @model)
    @found = any_results_specific?(@results)
  end
end
