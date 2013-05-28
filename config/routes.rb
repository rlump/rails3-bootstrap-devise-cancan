Rails3BootstrapDeviseCancan::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'users/:id/album/:album_id', to: 'users#show'
  get 'users/:id/pages/:page_id', to: 'users#page'
  post 'users/:id/pages/:page_id', to: 'users#page'

  resources :users
end
