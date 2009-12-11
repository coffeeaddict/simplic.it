class LoginController < ApplicationController

  def index
    @user = User.new
  end

  def login
    if @user = User.authenticate( params[:user][:username], params[:user][:password] )
      self.current_user = @user
      redirect_to :controller => "start", :action => "index"
    else
      render :action => "index"
    end
  end

  def logout
    session.delete(:user)
    redirect_to "/start"
  end
end
