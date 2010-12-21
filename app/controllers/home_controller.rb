# TODO: take the index and the copyright pages of the couch and place
# them on the platter^W disk
#
class HomeController < ApplicationController
  require 'lipsum'  

  def sub_menu
    [ 
      ['Freelance', :freelance],
      ['Resume', :resume],
      ['Contact', :contact]
    ]
  end

  def index
    @page = Page.find_by_path "/home/index"
    @blogs = Blog.order('created_at DESC').limit(2)
    @life_lines = LifeLine.all.sort_by { |l|
      l.publish_time.in_time_zone("Amsterdam")
    }.reverse.take 5
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
