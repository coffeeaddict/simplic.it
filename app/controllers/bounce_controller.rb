class BounceController < ApplicationController

  before_filter :check_login, :except => [ :index, :info ]

  def index
    if params[:id]
      return redirect_to :action => "info", :id => params[:id]
    end

    @bounce = Bounce.find(:all)
  end

  def new
    @bounce = Bounce.new()
  end

  def create
    @bounce = Bounce.new(params[:bounce])

    if @bounce.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def info
    @bounce = Bounce.find(params[:id])
  end
end
