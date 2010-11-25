class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # show my name
  def name
    self.class.name.downcase.gsub(/controller$/, "")
  end  
end
