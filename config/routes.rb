Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :restaurants do
    resources :menu_items, only: [ :index, :create ], module: :restaurants
  end
  resources :menu_items, only: [ :update, :destroy ]
end
