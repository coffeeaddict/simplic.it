class BlogController < ApplicationController
  def index
    @blogs = Blog.order( 'created_at DESC' ).limit(25)

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end
  
  def by_url_key
    unless ( @blog = Blog.find_by_url_key(params[:url_key]) )
      return not_found
    end
  end
  
  def by_tag
    unless (@tag = Tag.find_by_name(params[:tag]))
      return not_found
    end
    @blogs = @tag.blogs    
  end
end
