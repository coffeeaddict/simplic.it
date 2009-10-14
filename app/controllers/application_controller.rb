# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  layout "simplicity"

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery


  # make sure there is a language for template rendering
  def assign_language

    # if there is no session language, assign the default (which is NL)
    if session['language'].nil? || session['language'].empty?
      session['language'] = "NL";
    end

    # store the bounce-back URL
    session['bounce_back'] = controller_name;
  end

  # default index behaviour.
  def index

    # when the child has not set a title, make it the name of the
    # controller
    if @title.nil? || @title.empty?
      @title = controller_name.capitalize
    end

    # if the user is still logged in, show it
    if ( ( !session['logged_in'].nil? && !session['logged_in'].empty? ) &&
  	 ( @logged_in.nil? || @logged_in.empty? ) )
      @logged_in = true
    end

    render :template => controller_name.downcase <<
                        "/index_" <<
                        session['language'].downcase    
  end

  # check for a login or bounce to start
  def check_login
    
    if session['logged_in'].nil? || session['logged_in'].empty?
      redirect_to :controller => "start", :action => "index"
    end

    # pages which require login do not use default behavioure. Set logged_in attr. here
    @logged_in = true

  end

end
