DefaultSite::Application.routes.draw do
  scope 'admin' do
    resources :documents
    resources :galleries do
      resources :images
    end
    resources :pages do
      resources :widgets
    end
    resources :nav_menus do
      resources :nav_items
    end
    resources :users do
      member do
        get :change_password
      end
    end
    match '/', :to => 'admin#home', :as => 'admin_home'

    post "/nav_menus/order_nav_items", :to => 'nav_menus#order_nav_items', :as => :order_nav_items
    post "/order_images", :to => 'images#order_images', :as => :order_images
    post '/order_widgets', :to => 'pages#order_widgets', :as => :order_widgets
  end
  
  resources :sessions, :only => [:create]

  match '/signin', :to => 'sessions#new', :as => :signin
  match '/signout', :to => 'sessions#destroy', :as => :signout
  
  post '/add_region', :to => 'pages#add_region', :as => :add_region
  
  # Routes in the host application
  get '/pages/:id', :to => 'pages#show'
  match '/', :to => 'pages#show', :id => 'home', :as => :root
  
end
