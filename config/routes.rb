Realtime::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # only accept oauth
  # devise_scope :user do
  #   get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
  #   get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  # end
  resources :users, :only => [:show, :index]
  resources :games
  resources :queues do
    collection do
      get :add
    end
  end
  resources :messages
  resources :matches
  resources :leader_boards


  match 'twilios/call' => 'twilios#call'
  match 'twilio_callbacks/phone' => 'twilio_callbacks#phone'
  match 'pusher/auth' => 'pusher#auth'
end
