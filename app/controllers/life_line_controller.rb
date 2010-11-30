class LifeLineController < ApplicationController
  def index
    @life_lines = LifeLine.all.sort_by { |l|
      l.publish_time.in_time_zone("Amsterdam")
    }.reverse.take 50
  end
  
  def origin
    LifeLine.find_by_origin(params[:id])
  end
  
  def blog
    unless ( @life_line = LifeLine.find_by_url_key(params[:id]) )
      return render(:status => 404)
    end
  end
end