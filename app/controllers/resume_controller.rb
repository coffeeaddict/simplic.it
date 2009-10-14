class ResumeController < ApplicationController

  before_filter :assign_language

  def index
    @as_word = false;
    @title = session['language'].eql?("NL") ? "CV" : "Resume"
    super
  end

  def as_word
    @as_word = true;

    headers["content-disposition"] = "attachment; filename=hartog.de.mik.CV.doc"

    render :template => "resume/index_" << session['language'].downcase,
      :layout => false,
      :content_type => "application/ms-word"

  end
    
end
