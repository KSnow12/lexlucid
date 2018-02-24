Rails.application.routes.draw do
  root to: "documents#index"
  resources :bullet_points
  resources :ratings
  resources :reviews
  resources :document_types
  resources :documents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
