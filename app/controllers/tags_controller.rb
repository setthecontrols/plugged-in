class TagsController < ApplicationController

  def new
    @tag = Tag.new
  end

  def create
    @tag = find_or_create_by(tag_params)
    @tag_post
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
