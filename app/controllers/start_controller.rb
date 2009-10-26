class StartController < ApplicationController

  before_filter :assign_language

  def index
    if params[:id]
      bounce = Bounce.find( :first,
			    :conditions => [ "public_id=?", params[:id] ]
			  )

      if bounce
	bounce.increment!('clicks')
	return redirect_to bounce.url, :status => 302

      else
	return render :text => "Not found", :status => 404

      end
    end

    super
  end
end
