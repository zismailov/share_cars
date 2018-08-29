Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :trips, except: [:destroy] do
    member do
      get "confirm"
      get "delete"
    end
    resources :messages
  end

  resources :geocodes do
    collection do
      get "autocomplete"
    end
  end

  get "search", to: "search#index"
  get "homes/index"

  root to: "homes#index"
end
