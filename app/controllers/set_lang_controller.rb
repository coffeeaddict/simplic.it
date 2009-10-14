class SetLangController < ApplicationController

  def index

    # cannot use the filter; it would kill the bounce-back, so de-nil
    # the session just to be sure.
    if session['language'].nil?
      session['language'] = "NL";
    end

    # if there is a parameter, set the language
    if !params['lang'].nil?
      session['language'] = params['lang'].upcase;
    end

    # bounce back
    begin
      redirect_to :back
      return
    rescue
      # do nothing, we will use the session bounce back
    end

    begin
      redirect_to :controller => session['bounce_back']
    rescue
      # nothing to bounce back to, bounce to start
      redirect_to :controller => 'start';
    end

  end

end
