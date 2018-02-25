Rails.application.routes.draw do
  get 'welcome/index'

  root to: "documents#index"
  resources :bullet_points
  resources :ratings
  resources :document_types
  resources :reviews, only: [:index]
  resources :documents, shallow: true do
    resources :reviews, except: [:index]
  end
  resources :users

  get '/login', to: 'users#login'
  post '/login', to: 'users#login'
  delete '/logout', to: 'users#logout'
end
