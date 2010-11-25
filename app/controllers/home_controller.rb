class HomeController < ApplicationController
  before_filter :set_menu

  def set_menu
    @menu_select = { :controller => "home" }
  end

  def index
  end
  
  def freelance
    render :action => :index
  end
  
  def resume
  end

  def copyright
  end
end
