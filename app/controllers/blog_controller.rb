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
    @title = @blog.title
  end
  
  def by_tag
    unless (@tag = Tag.find_by_name(params[:tag]))
      return not_found
    end
    @blogs = @tag.blogs    
    @title = "Tag: #{@tag.name} - Blogs"
  end
  
  def archive
    year  = params[:year]
    month = params[:month]
        
    @title = "Archive #{year}"

    template = "%Y"
    @period  = "%i" % year
    unless month.blank?
      template += "/%m"
      month = "/%02i" % month.gsub(/^0+/, "")
      @period  += month
      @title   += month
    end
    
    @blogs = Blog.where( [ "strftime('#{template}', created_at)=?", @period] )
  rescue ArgumentError => e    
    @blogs = []
    @error = true
    
  end
end
