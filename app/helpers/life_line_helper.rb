module LifeLineHelper
  def twitter_link_up line
    words = line.split " "
    words.each_index do |i|
      word = words[i]
      if word =~ /^\@[^\s]+/
        word = link_to word, "http://twitter.com/#!/#{word.gsub(/^\@/, '')}"
        
      elsif word =~ /^\#[^\s]+/
        word = link_to(
          word, "http://twitter.com/#!/search/#{word.gsub("#", "%23")}"
        )
        
      elsif word =~ /^http(s?)\:\/\//i
        word = link_to word, word     
        
      end
      
      words[i] = word
    end
    
    return words.join " "
  end
  
  def github_link_up line
    line.gsub(/href=\"/, 'href="https://github.com')
  end
  
  def link_up line
    words = line.split " "
    words.each_index do |i|
      word = words[i]
      if word =~ /^http(s?)\:\/\//i
        word = link_to word, word
      end
      
      words[i] = word
    end
    
    return words.join " "
  end
end
