Rails.application.routes.draw do
  root to: "documents#index"
  resources :bullet_points
  resources :ratings
  resources :reviews
  resources :document_types
  resources :documents
  resources :users
end
