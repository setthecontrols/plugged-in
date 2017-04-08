 module SearchHelper

  def search_all(keyword)
    results = {categories: [], posts: [], users: {name: [], genre: [], instruments: [], location: []}}
    categories = Boardcategory.all
    results[:categories] = categories.select {|cat| cat.name.include?(keyword) }
    posts = Boardpost.all
    results[:posts] = posts.select {|post| post.title.include?(keyword) }
    users = User.all
    results[:users][:name] = users.select {|user| user.full_name.include?(keyword) || user.username.include?(keyword)} #make a full_name method
    results[:users][:instruments] = users.select {|user| user.instruments.include?(keyword)}
    results[:users][:location] = users.select {|user| user.location.include?(keyword)}
    results[:users][:genre] = users.select {|user| user.genre.include?(keyword)}
    return results
  end

  def any_results_all?(results)
    return false if results[:posts].none? && results[:categories].none? && results[:users][:name].none? && results[:users][:genre].none? && results[:users][:location].none? && results[:users][:instruments].none?
    true
  end

  def search_specific(keyword, model)
    results = {}
    if model == "categories"
      categories = Boardcategory.all
      results[:categories] = categories.select {|cat| cat.name.include?(keyword) }
    elsif model == "posts"
      posts = Boardpost.all
      results[:posts] = posts.select {|post| post.title.include?(keyword) }
    elsif model.include?("users")
      users = User.all
      if model == "users-all"
        results[:users][:name] = users.select {|user| user.full_name.include?(keyword) || user.username.include?(keyword)} #make a full_name method
        results[:users][:instruments] = users.select {|user| user.instruments.include?(keyword)}
        results[:users][:location] = users.select {|user| user.location.include?(keyword)}
        results[:users][:genre] = users.select {|user| user.genre.include?(keyword)}
      elsif model == "users-location"
        results[:users][:location] = users.select {|user| user.location.include?(keyword)}
      elsif model == "users-genre"
        results[:users][:genre] = users.select {|user| user.genre.include?(keyword)}
      elsif model == "users-instruments"
        results[:users][:instruments] = users.select {|user| user.instruments.include?(keyword)}
      elsif model == "users-name"
         results[:users][:name] = users.select {|user| user.full_name.include?(keyword) || user.username.include?(keyword)} #make a full_name method
      end
    end
    return results
  end

  def any_results_specific?(results)
    return false if results.none?
    true
  end
end
