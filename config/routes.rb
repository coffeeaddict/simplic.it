ActionController::Routing::Routes.draw do |map|
  # You can have the root of your site routed with map.root -- just
  # remember to delete public/index.html.
  #
  map.root :controller => "start"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
