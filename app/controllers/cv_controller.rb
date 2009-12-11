class CvController < ApplicationController

  def index
    @as_word = false;
  end

  def as_word
    @as_word = true;

    headers["content-disposition"] = "attachment; filename=hartog.de.mik.CV.doc"

    render :template => "resume/index",
      :layout => false,
      :content_type => "application/ms-word"
  end
    
end
