class HomeController < ApplicationController
  require 'lipsum'  

  def sub_menu
    [ ['Resume', :resume],
      ['Freelance', :freelance],
      ['Contact', :contact]
    ]
  end
  
  def index
    @page = Page.find_by_path "/home/index"
    Rails.logger.info "A: #{params[:action]}"
  end
  
  def freelance
    l = []; (rand(5)+1).times { l << Lipsum.paragraph }
    @page = Page.new(
      :title => "Lorem ipsum dolor sit random",
      :contents => l.join("<br /><br />"),
      :info => "<h3>More info</h3><p>" + Lipsum.paragraph +
               "</p><span class='small alt'>Do it. Hit F5 &nbsp; &nbsp; :)</span>" 
    )
    
    render :action => :index
  end
  alias_method :resume, :freelance
  alias_method :contact, :freelance
  
  def copyright
    @page = Page.find_by_path "/home/copyright"
    render :action => :index
  end  
end
