Realtime::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]
  resources :games
  resources :queues do
    collection do
      get :add
    end
  end
  resources :messages
  resources :matches

  match 'pusher/auth' => 'pusher#auth'
end
