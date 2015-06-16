Rails.application.routes.draw do
 
  get 'contact_form/new'

  get 'contact_form/create'

  resources :blogs, only: [:index, :show]

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
  
  resources :contact_forms, only: [:new, :create]

  %w[home about].each do |page|
    get page, controller: "pages", action: page
  end

  
  root 'pages#home'
  
  get 'user_root' => 'entries#index'

end
