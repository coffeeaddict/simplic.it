Webapp::Application.routes.draw do
  
  match '/blog' => "blog#index"
  match '/blog/:url_key.html' => "blog#by_url_key", :as => "blog_key", :format => :html
  match '/blog/tag/:tag' => "blog#by_tag"
  match '/blog/archive/:year(/:month)' => "blog#archive"
  
  match '/:controller/pygment' => '#pygment'
  
  namespace :home do
    match :index
    %w( freelance resume copyright contact ).each do |action|
      match "#{action}" => { :controller => :home, :action => :index }
    end
  end
  
  match '/life_line' => 'life_line#index'
  match '/life_line/index' => 'life_line#index'
  match '/life_line/by_origin/:origin' => 'life_line#by_origin'
  
  namespace :tools do
    match :index
  end
  
  root :to => "home#index"  
end
