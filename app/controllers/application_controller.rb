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
end
