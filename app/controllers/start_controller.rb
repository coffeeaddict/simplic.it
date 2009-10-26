class StartController < ApplicationController

  before_filter :assign_language

  def index
    if params[:id]
      bounce = Bounce.find( :first,
			    :conditions => [ "public_id=?", params[:id] ]
			  )

      if bounce
	bounce.clicks += 1
	bounce.save

	return redirect_to bounce.url, :status => 302
      end
    end

    super
  end
end
