Webapp::Application.routes.draw do
  
  match '/blog' => "blog#index"
  match '/blog/:url_key' => "blog#by_url_key"
  match '/blog/tag/:tag' => "blog#by_tag"
  
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
