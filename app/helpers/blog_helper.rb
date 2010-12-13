module BlogHelper
  # Get the (file) contents of a blog
  def contents blog
    File.read(blog.file).html_safe
  end
  
  # Get the excerpt of a blog
  #
  # When; a <!-- more --> tag is defined, that defines the excerpt.
  # Else; the excerpt is defined by the first </p>
  #
  # When; no excerpt was found, or the excerpt defined by </p> was less then 
  #       800 characters, find the last word before the 1024th character, 
  #       balance the tags and let that be the excerpt
  #
  def excerpt blog
    string = contents(blog)

    excerpt = nil
    if ( more = string.match /<!--\s?more\s?-->/ )
      excerpt = string[0...more.begin(0)]
      
    elsif ( p = string.match /<\/p>/ )
      excerpt = string[0...p.begin(0)]
      
    end
    
    if excerpt.nil? or ( !p.nil? and excerpt.length < 800 )
      excerpt = string[0...string[0..1024].rindex(" ")]
      excerpt = balance_tags(excerpt)
    end
    
    excerpt + link_to(
      "Read More",
      { :controller => :blog,
        :action     => :by_url_key,
        :url_key    => blog.url_key
      },
      { :class => "more_link" }
    )
  end
end