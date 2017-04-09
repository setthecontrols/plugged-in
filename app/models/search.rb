class Search < ApplicationRecord
  # add blank keyword condition
  def find(keyword)
    results = {categories: [], posts: []}
    categories = Boardcategory.all
    posts = Boardpost.all
    results[:categories] = categories.select {|cat| cat.name.include?(keyword) }
    results[:posts] = posts.select {|post| post.title.include?(keyword) }
    return results
  end
end
