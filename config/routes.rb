Rails.application.routes.draw do
  get 'welcome/index'

  root to: "documents#index"
  resources :bullet_points, except: [:show]
  resources :document_types, except: [:show]
  resources :documents, shallow: true do
    resources :reviews, except: [:show, :index]
    resources :reviews, except: [:index]
    get :find, on: :collection
  end
  resources :users

  get '/login', to: 'users#login'
  post '/login', to: 'users#login'
  delete '/logout', to: 'users#logout'
  get '/clear', to: 'users#clear'
end
