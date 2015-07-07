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

  resources :users do
    get :get_user, on: :collection
  end
  resources :resources, only: [:create, :destroy]

  resources :entries do
    resources :resources, only: [:create, :destroy]
    get :tag_list, on: :collection
    get :user_list, on: :collection
    get :edit_tags, on: :member
    put :update_tags, on: :member
    put :share, on: :member
    get :hide, on: :member
    put :share_with_user, on: :member
    put :remove_user, on: :member
    put :share_with_group, on: :member
    put :remove_from_group, on: :member
  end

  resources :groups do
    get :new_member, on: :member
    post :create_member, on: :member
    get :remove_member, on: :member
  end
  
  resources :contact_forms, only: [:new, :create]

  %w[home about].each do |page|
    get page, controller: "pages", action: page
  end

  
  root 'pages#home'
  
  get 'user_root' => 'entries#index'

end
