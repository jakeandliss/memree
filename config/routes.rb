Rails.application.routes.draw do
 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'users/registrations' }


  get 'labels/new', to: 'tags#new', as: "new_label"
  resources :tags, :path => "labels"

  
  get "/login" => "user_sessions#new", as: :login
  delete "/logout" => "user_sessions#destroy", as: :logout

  resources :users 
  resources :resources, only: [:create, :destroy]

  resources :entries do
    resources :resources, only: [:create, :destroy]
    get :tag_list, on: :collection
  end
  

  %w[home about].each do |page|
    get page, controller: "pages", action: page
  end

  
  root 'pages#home'
  
  get 'user_root' => 'entries#index'

end
