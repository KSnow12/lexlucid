Rails.application.routes.draw do
  root to: "documents#index"
  resources :bullet_points
  resources :ratings, shallow: true do
    resources :reviews
  end
  #resources :reviews
  resources :document_types
  resources :documents
  resources :users
end
