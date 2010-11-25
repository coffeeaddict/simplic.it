class HomeController < ApplicationController
  require 'lipsum'
  
  before_filter :set_menu

  def set_menu
    @menu_select = { :controller => "home" }
  end

  def index
    @page = Page.find_by_path "/home/index"
  end
  
  def freelance
    l = []; (rand(5)+1).times { l << Lipsum.paragraph }
    @page = Page.new(
      :title => "Lorem ipsum dolor sit random",
      :contents => l.join("<br /><br />"),
      :info => "<h3>More info</h3><p>" + Lipsum.paragraph +
               "</p><span class='small alt'>do it. hit F5</span>" 
    )
    
    render :action => :index
  end
  
  def resume
  end

  def copyright
  end
end
