Rails.application.routes.draw do
  root to: "documents#index"
  resources :bullet_points
  resources :ratings
  #resources :reviews
  resources :document_types
  resources :reviews, only: [:index]
  resources :documents, shallow: true do
    resources :reviews, except: [:index]
  end
  resources :users
end
