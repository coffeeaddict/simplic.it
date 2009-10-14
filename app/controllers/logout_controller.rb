class LogoutController < ApplicationController

  def index
    session["logged_in"] = nil
    redirect_to :controller => "start"
  end

end
