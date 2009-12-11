class BlogController < ApplicationController

  before_filter :check_login, :only => [ :admin, :edit, :hide, :destroy ]

  def index
    @blog = Blog.find( :all, :order => "created_at DESC" )
  end

  def view
    unless @blog = Blog.find_by_title( params[:id].gsub("_", " ") )
      return render(:text => "There is no such entry", :layout => true)
    end
    @blog.increment!('views')
  end

  def tag
    @tag  = Tag.find_by_name(params[:id])
    @blog = @tag.blogs
  end

  def admin
    return render(:status => 403, :text => "forbidden") unless current_user

    @blog = Blog.all
  end

  def edit
    @blog = Blog.find(params[:id])

    if params[:blog]
      @blog.update_attributes(params[:blog])
    end
  end

  def destroy
    Blog.find(params[:id]).destroy
    redirect_to :action => :admin
  end

  def new
    @blog = Blog.create( :user => current_user )
    redirect_to :action => :edit, :id => @blog.id
  end

  def comment
    if verify_recaptcha()
      comment = Comment.new(params[:comment])

      # when you have no name you are an anonymous coward and get no website
      if comment.name and comment.name.empty?
        comment.name = "anonymous coward" 
        comment.website = ""
      end
      
      comment.save
      render(:update) { |page|
        page.insert_html(
          :bottom, 'comments',
          render(:partial => "comment", :locals => { :comment => comment })
        )
      }
    else
      render :text => "are you not human?", :status => 403
    end
  end

  def delete_comment
    comment = Comment.find(params[:id])
    @blog = comment.blog

    comment.destroy

    render :text => "Gone"
  end

  def add_tag
    b = Blog.find(params[:id])
    tag = Tag.find(params[:tag_id])
    unless b.tags.include? tag
      b.tags << tag 
      render(:update) { |page|
        page.insert_html( :bottom, 'blog_tags',
          render(:partial => "blog_tag", :locals => { :tag => tag })
        )
      }
    else
      render :text => "Already has that tag"
    end
  end

  def drop_tag
    b = Blog.find(params[:id])
    tag = Tag.find(params[:tag_id])
    b.tags = b.tags - [ tag ]

    render(:update) { |page|
      page.remove "project_tag_#{tag.id}"
      page.replace_html 'message', 'OK!'
    }

    return "OK"
  end

  def new_tag
    tag = Tag.create(params[:tag])
    
     render(:update) { |page|
       page.insert_html( :bottom, 'available_tags',
         render(:partial => "tag", :locals => { :tag => tag })
       )
     }
  end
end
