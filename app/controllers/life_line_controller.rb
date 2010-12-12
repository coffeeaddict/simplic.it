class LifeLineController < ApplicationController
  def sub_menu
    %w(twitter github bitly flickr).collect { |origin| 
      [ origin, { :action => :by_origin, :origin => origin } ]
    }
  end
  
  def index
    @life_lines = LifeLine.all.sort_by { |l|
      l.publish_time.in_time_zone("Amsterdam")
    }.reverse.take 50
  end
  
  def by_origin
    @life_lines = LifeLine.all_by_origin(params[:origin]).sort_by { |l|
      l.publish_time.in_time_zone("Amsterdam")
    }.reverse.take 75
    
    render 'index'
  end
end