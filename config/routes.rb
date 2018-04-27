Rails.application.routes.draw do
  resources :trips

  get "homes/index"

  root to: "homes#index"
end
