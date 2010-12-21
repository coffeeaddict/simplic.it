require 'lib/lipsum'

module ApplicationHelper
  # render a link inside a <li> with class=selected when applicable
  #
  def menu_link(text, opts={})
    if opts[:action].is_a? Hash
      opts.merge! opts[:action]
      Rails.logger.info opts.inspect
    end
    
    selected = opts[:controller].to_s == controller.name
    selected = opts[:origin].to_s == params[:origin] if !selected
    selected = opts[:action].to_s == params[:action] if !selected and !opts[:origin]
    
    ( "<li #{selected ? "class='selected'" : ""}" + 
      " data-url='#{url_for(opts)}'>#{text}</li>"
    ).html_safe
  end
  
  # generate count paragraphs of lipsum
  #
  def lorem count=1
    res = []
    count.times { res << Lipsum.paragraph }
    "<p>#{res.join("</p>\n<p>")}</p>".html_safe
  end
  
  # Close the tags openend on the string
  #
  def balance_tags string
    # downcase all tags
    string.gsub!(/\<[^\>]+\>/) { |s| s.downcase }
    
    # get all the open tags
    opens = string.scan /\<[^\/][^\>]*\>/m
    
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
