# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user
    return session[:user]
  end

  def top_link_to(name, url)
    link = link_to(name, url)

    # if the URL is the current controller - make it bold
    if ( url == "/" + params[:controller] ) or
       ( url == "/" + params[:controller] + "/" + params[:action] )
      link = "<h3>#{link}</h3>"
    end

    return link
  end

  def content_filter(content, filter_html=false)
    # disable HTML?
    filtered = content

    if filter_html == true
      filtered.gsub!("<", "&lt;");
    end

    # make urls link (unless they begin with a quote, because then
    # they are already linked)
    #
    filtered.gsub!(/[^\"\']https?\:\/\/[^\s\"]+/) { |link|
      # now is this beautiful ruby code or what?
      link = link_to link, link
    }

    # make new lines visible
    filtered.gsub!(/\r?\n/, "<br />")

    return filtered
  end

end
