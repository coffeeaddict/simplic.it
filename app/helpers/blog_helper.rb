module BlogHelper
  def excerpt(blog)
    words = blog.content.split(/\s/)

    if words.length < 60
      return content_filter(blog.content)
    end

    

    # find an excerpt
    excerpt      = []
    tried_words  = 59
    max          = 90
    good_excerpt = false

    while not good_excerpt do
      excerpt = words[0..tried_words]
      
      opens = excerpt.select {|w| w =~ /<[^\/]/ and w !~ /<br/ and w !~ /<\// }
      closes = excerpt.select {|w| w =~ /<\// and w !~ /<br/ and w !~ /<[^\/]/ }

      RAILS_DEFAULT_LOGGER.error "e: #{excerpt.length}"
      RAILS_DEFAULT_LOGGER.error "o: #{opens.length} - c: #{closes.length}"
      RAILS_DEFAULT_LOGGER.error "O: #{opens.inspect}"
      RAILS_DEFAULT_LOGGER.error "C: #{closes.inspect}"

      if opens.length != closes.length
        good_excerpt = false
        tried_words += 1
      else
        good_excerpt = true
      end

      break if tried_words > max
    end

    final_excerpt = excerpt.join(" ")
    final_excerpt += " "+link_to("[...]", :action => :view, :id => slug(blog))

    final_excerpt
  end

  def slug(blog)
    return if !blog.title
    return blog.title.downcase.gsub(" ", "_")
  end

  def url(blog)
    return "http://simplic.it/blog/view/#{slug(blog)}"
  end

  def tag_link(tag)
    link_to tag.name, :controller => :blog, :action => :tag, :id => tag.name
  end
end

#  LocalWords:  True
