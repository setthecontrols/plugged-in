 module SearchHelper

  def search(keyword)
    results = {categories: [], posts: []}
    categories = Boardcategory.all
    posts = Boardpost.all
    results[:categories] = categories.select {|cat| cat.name.include?(keyword) }
    results[:posts] = posts.select {|post| post.title.include?(keyword) }
    return results
  end

  def any_results?(results)
    return false if results[:posts].none? && results[:categories].none?
    true
  end
end
