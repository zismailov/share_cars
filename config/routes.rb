Rails.application.routes.draw do
  resources :trips
  resources :searches

  resources :geocodes do
    collection do
      get "autocomplete"
    end
  end

  get "homes/index"

  root to: "homes#index"
end
