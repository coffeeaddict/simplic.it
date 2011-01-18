module BlogHelper
  include HtmlExcerpts
  
  # Get the (file) contents of a blog
  def contents blog
    File.read(blog.file_path).html_safe
  end
  
  def url(blog)
    url_for( :controller => :blog ) + "/#{blog.url_key}.html"
  end
  
end
