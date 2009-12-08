class BlogController < ApplicationController

  def index
    @blog = Blog.find( :all, :order => "created_at DESC" )
  end

  def view
    begin
      if params[:id].kind_of?(Fixnum)
	@blog = Blog.find(params[:id])
      else
        title = params[:id].gsub("_", " ")

	RAILS_DEFAULT_LOGGER.error "Title: #{title}"

	unless @blog = Blog.find(
          :first,
	  :conditions => [ "title like ?", "%#{title}%" ]
        )
          raise ActiveRecord::RecordNotFound.new
        end
      end
    rescue ActiveRecord::RecordNotFound
      return render :text => "There is no such entry", :layout => true
    end
  end
end
