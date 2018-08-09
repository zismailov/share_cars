Rails.application.routes.draw do
  resources :trips

  resources :geocodes do
    collection do
      get "autocomplete"
    end
  end

  post "search", to: "search#index"
  get "homes/index"

  root to: "homes#index"
end
