class LoginController < ApplicationController

  def index
    @user = User.new
  end

  def login
    @user = User.find(:first, :conditions => [ "username = ? AND password = MD5(?)",
		                               params[:user][:username], params[:user][:password] ] )
    
    if ( !@user.nil? && @user.username && @user.password ) 
      session["logged_in"] = @user.username
      redirect_to :controller => "start", :action => "index"
    else
      render :action => "index"
    end

  end
end
