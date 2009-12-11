# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  layout "simplicity"
  protect_from_forgery
  filter_parameter_logging :password, :new_password, :password_confirm

  acts_as_authenticator_for User

  # check for a login or bounce to start
  def check_login
    unless current_user
      redirect_to :controller => "login", :action => "index"
    end

    # pages which require login do not use default behavioure. Set logged_in attr. here
    @logged_in = true

  end

end
