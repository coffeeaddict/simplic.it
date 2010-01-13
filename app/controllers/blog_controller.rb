class BlogController < ApplicationController

  before_filter :check_login, :only => [ :admin, :edit, :hide, :destroy ]

  def index
    @blog = Blog.find :all,
      :conditions => { :published => true }, 
      :order => "`order` ASC"
  end

  def rss
    @blog = Blog.find :all,
      :conditions => { :published => true }, 
      :order => "`order` ASC"

    render :layout => false
  end


  def view
    unless @blog = Blog.find_by_title( params[:id].gsub("_", " ") )
      return render(:text => "There is no such entry", :layout => true)
    end

    @blog.increment!('views') unless current_user
  end

  def tag
    @tag  = Tag.find_by_name(params[:id])
    @blog = @tag.blogs
  end

  def admin
    return render(:status => 403, :text => "forbidden") unless current_user

    @blog = Blog.all( :order => "`order` ASC" )
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

      Notifications.deliver_new_comment( comment )

      render(:update) { |page|
        page.insert_html :bottom, 'comments',
          render(:partial => "comment", :locals => { :comment => comment })
        
        page.replace_html 'comment_form',
          :partial => 'comment_form', :locals => { :id => comment.blog.id }
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
    @blog = Blog.find(params[:id])
    tag = Tag.find(params[:tag_id])
    unless @blog.tags.include? tag
      @blog.tags << tag 
      render(:update) { |page|
        page.insert_html( :bottom, 'blog_tags',
          render(:partial => "blog_tag", :locals => { :tag => tag })
        )
      }
    else
      render(:update) { |page|
        page.replace_html 'message', "Already has that tag"
      }
    end
  end

  def drop_tag
    b = Blog.find(params[:id])
    tag = Tag.find(params[:tag_id])
    b.tags = b.tags - [ tag ]

    render(:update) { |page|
      page.remove "blog_tag_#{tag.id}"
      page.replace_html 'message', 'OK!'
    }
  end

  def new_tag
    tag = Tag.create(params[:tag])
    
     render(:update) { |page|
       page.insert_html( :bottom, 'available_tags',
         render(:partial => "tag", :locals => { :tag => tag })
       )
     }
  end

  def order 
    count = 0

    begin
      params[:list].each { |id|
        Blog.find(id).update_attributes( :order => ( count += 1 ) );
      }
    rescue
      return render(:text => "O_o somethings wrong")
    end

    render :text => "OK"
  end

  def order_tags
    blog = Blog.find(params[:id])
    blog.tags = []
    params[:blog_tags].each { |id|
      blog.tags << Tag.find(id)
    }
    
    render :text => "OK"
  end
end
