Rails.application.routes.draw do
  resources :musics
  resource :users, only: [:create]
  post "/login", to: "users#login"

  get "up" => "rails/health#show", as: :rails_health_check
end
