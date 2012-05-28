ActionController::Routing::Routes.draw do |map|
  # map.namespace :admin, :member => { :remove => :get } do |admin|
  #   admin.resources :visitor
  # end
  
  map.auth '/auth/:provider/callback', :controller => 'authentications', :action => 'create'
  map.resources :authentications
  map.resources :users
  map.sign_up '/sign_up', :controller => 'users', :action => 'sign_up'
  map.logout '/logout', :controller => 'users', :action => 'logout'
end