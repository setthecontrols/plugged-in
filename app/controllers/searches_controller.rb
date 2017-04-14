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
    puts @found
    puts @results
    if @model == "users-all"
      @displayed_model = "Musicians"
    elsif @model == "posts"
      @displayed_model = "Postings"
    elsif @model == "categories"
      @displayed_model = "Listing Categories"
    elsif @model == "users-location"
      @displayed_model = "Location"
    elsif @model == "users-genre"
      @displayed_model = "Genres"
    elsif @model == "users-instruments"
      @displayed_model = "Instruments"
    elsif @model == "users-name"
      @displayed_model = "Musicians by Name"
    end
  end
end
