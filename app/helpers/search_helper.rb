 module SearchHelper

  def search_all(keyword)
    results = {categories: [], posts: [], users: []}
    categories = Boardcategory.all
    results[:categories] = categories.select {|cat| cat.name.downcase.include?(keyword) }
    posts = Boardpost.all
    results[:posts] = posts.select {|post| post.title.downcase.include?(keyword) }
    users = User.all
    results[:users] << users.select {|user| user.full_name.downcase.include?(keyword) || user.username.include?(keyword)}
    results[:users].flatten!
    results[:users] << users.select {|user| user.instruments.downcase.include?(keyword)}
    results[:users].flatten!
    results[:users] << users.select {|user| user.location.downcase.include?(keyword)}
    results[:users].flatten!
    results[:users] << users.select {|user| user.genre.downcase.include?(keyword)}
    results[:users].flatten!
    results[:users].uniq!
    return results
  end

  def any_results_all?(results)
    return false if results[:posts].none? && results[:categories].none? && results[:users].none?
    true
  end

  def search_specific(keyword, model)
    results = {}
    if model == "categories"
      categories = Boardcategory.all
      results[:categories] = categories.select {|cat| cat.name.downcase.include?(keyword) }
    elsif model == "posts"
      posts = Boardpost.all
      results[:posts] = posts.select {|post| post.title.downcase.include?(keyword) }
    elsif model.include?("users")
      users = User.all
      if model == "users-all"
        results[:users] = []
        results[:users] << users.select {|user| user.full_name.downcase.include?(keyword) || user.username.include?(keyword)}
        results[:users].flatten!
        results[:users] << users.select {|user| user.instruments.downcase.include?(keyword)}
        results[:users].flatten!
        results[:users] << users.select {|user| user.location.downcase.include?(keyword)}
        results[:users].flatten!
        results[:users] << users.select {|user| user.genre.downcase.include?(keyword)}
        results[:users].flatten!
        results[:users].uniq!
      elsif model == "users-location"
        results[:users] << users.select {|user| user.location.downcase.include?(keyword)}
        results[:users].flatten!
      elsif model == "users-genre"
        results[:users] << users.select {|user| user.genre.downcase.include?(keyword)}
        results[:users].flatten!
      elsif model == "users-instruments"
        results[:users] << users.select {|user| user.instruments.downcase.include?(keyword)}
        results[:users].flatten!
      elsif model == "users-name"
         results[:users] << users.select {|user| user.full_name.downcase.include?(keyword) || user.username.downcase.include?(keyword)} #make a full_name method
        results[:users].flatten!
      end
    end
    return results
  end

  def any_results_specific?(results)
    return false if results.none?
    true
  end

  def advanced_results_partial(type)
    if type.include?("users")
      render "searches/users_results"
    elsif type == "posts"
      render "searches/posts_results"
    else type == "categories"
      render "searches/categories_results"
    end
  end
end
