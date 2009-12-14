module BlogHelper
  def excerpt(blog)
    words = blog.content.split(/ /)

    if words.length < 60
      return content_filter(blog.content)
    end

    excerpt = words[0..59].join(" ") + 
      " " + link_to("[...]", :action => :view, :id => slug(blog))
    
    content_filter(excerpt)
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
