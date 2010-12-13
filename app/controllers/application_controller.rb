require 'net/http'
require 'uri'
require 'digest/md5'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # show my name
  def name
    self.class.name.underscore.gsub(/_controller$/, "")
  end  
  
  # generic not found
  def not_found
    render(:file => "404.html", :layout => true, :status => 404)
  end
  
  def pygment
    code = CGI::unescapeHTML params[:code]
    lang = params[:lang]
    
    pygmented = Rails.cache.fetch(Digest::MD5.hexdigest(code)) do      
      request = Net::HTTP.post_form(
        URI.parse('http://pygments.appspot.com/'), {'lang'=>lang, 'code'=>code}
      )
      request.body.gsub("class=\"highlight\"", "class='pygmented'")
    end
    
    Rails.logger.info pygmented
    
    render :text => pygmented.html_safe
  end
end
