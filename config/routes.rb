ActionController::Routing::Routes.draw do |map|
  # You can have the root of your site routed with map.root -- just
  # remember to delete public/index.html.
  #
  map.root :controller => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '/:id', :controller => "home"
end
