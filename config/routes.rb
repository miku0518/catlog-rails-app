Rails.application.routes.draw do
  devise_for :users

  post '/guest_sign_in', to: 'guest_sessions#create' #ゲストログイン

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
  #アカウントページを表示する
  get "account", to: "users#account", as: :account
  resource :profile, only: [:edit, :update, :create]
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
  resources :comments, only: [:create, :destroy]  #ネスト→どの投稿に対するコメントか
  resource  :like, only: [:create, :destroy]     #ネスト→1つの投稿に「自分のいいね」は1つ
  end
end
