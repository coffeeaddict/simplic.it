class HomeController < ApplicationController
  def index
  end
  
  def freelance
    render :action => :index
  end
  
  def resume
  end

  def copyright; end
end
