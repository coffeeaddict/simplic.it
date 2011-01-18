# some methods for making excerpts from HTML
module HtmlExcerpts
  
  # Get the excerpt of a html-string with a default length of 1024 chars
  #
  # When; a <!-- more --> tag is defined, that defines the excerpt.
  # Else; the excerpt is defined by the first </p>
  #
  # When; no excerpt was found, or the excerpt defined by </p> was less then 
  #       768 (3/4 of the length) characters, find the last word before the
  #       1024th character, balance the tags and let that be the excerpt
  #
  # The returned string is deemed html_safe (why else would you want a tag 
  # balanced excerpt)
  #
  def excerpt string, length = 1024
    return string.html_safe if string.length < length

    excerpt = nil
    if ( more = string.match /<!--\s?more\s?-->/i )
      excerpt = string[0...more.begin(0)]
      
    elsif ( p = string.match /<\/p>/ )
      excerpt = string[0...p.begin(0)] + "</p>"
      
    end
    
    # more tags always win
    if more.nil?
      # the minimal lenght is 3/4th of the desired length
      min_length = ((length / 4)*3)
      
      # when no excerpt was found, when to long or to short, make a substr. index
      if excerpt.nil? or ( excerpt.length > length ) or ( excerpt.length < min_length )
        excerpt = string[0...string[0..length].rindex(" ")]
        excerpt = balance_tags(excerpt + "...")
        
      else      
        excerpt += "..."
        
      end
    end
    
    excerpt.html_safe
  end
  
  # Close the tags openend on the string
  #
  def balance_tags string
    # downcase all tags
    string.gsub!(/\<[^\>]+\>/) { |s| s.downcase }
    
    # get all the open tags
    opens = string.scan /\<[^\/!][^\>]*\>/m
    
    # remove all the attributes
    opens = opens.collect { |o| o.match('<([^\s\>]+)')[0] + ">".html_safe }
    
    # remove self closing tags
    opens -= opens.select { |o| 
      o =~ /\<(hr|br)\s?\/\>|\<(img|meta)[^\>]+\/?\>/
    }
    
    # get all the closing tags
    closes = string.scan /\<\/[^\>]+\>/m
    
    # let's get busy
    opens.uniq.each do |open|
      # define the closing tag for this open
      close = open.gsub('<', '</')
      
      unless closes.include? close        
        # when there is no such closing tag, add it
        string += close
        
      else
        # when the open counts not matches the close count, add more closing
        # tags
        close_count = closes.select { |c| close == c }.count
        open_count  = opens.select { |o| open == o }.count
        1.upto((close_count-open_count).abs) do          
          string += close
        end
      end
    end
    
    string
  end 
end