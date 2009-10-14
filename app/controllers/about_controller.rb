class AboutController < ApplicationController

  before_filter :assign_language

  def index
    @title = session['language'].eql?("NL") ? "Over" : "About"

    super
  end
end
