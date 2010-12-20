# TODO: take the index and the copyright pages of the couch and place
# them on the platter^W disk
#
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

  def copyright
    @page = Page.find_by_path "/home/copyright"
    render :action => :index
  end  
  
  def resume
    render :text   => File.read(path_to_file("resume.html")),
           :layout => true
  end

  def freelance
    render :text   => File.read(path_to_file("freelance")),
           :layout => true
  end

  def contact
    render :text   => File.read(path_to_file("contact.html")),
           :layout => true
  end

  def path_to_file file
    file += ".html" if file !~ /.html$/;
    File.join(Rails.root, "pages", file)
  end

  hide_action :path_to_file
end
