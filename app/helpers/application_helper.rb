require 'lib/lipsum'

module ApplicationHelper
  def menu_link(text, opts={})
    selected = false
    if opts[:action].blank?
      selected = true if opts[:controller].to_s == controller.name

    elsif opts[:action].to_s == params[:action] and opts[:controller].to_s == controller.name
      selected = true
    
    elsif @menu_select and ( opts[:controller] == @menu_select[:controller] )
      selected = true
      
    end

    "<li #{selected ? "class='selected'" : ""} data-url='#{url_for(opts)}'>#{text}</li>".html_safe
  end
  
  def lorem count=1
    res = []
    count.times { res << Lipsum.paragraph }
    "<p>#{res.join("</p>\n<p>")}</p>".html_safe
  end
end
