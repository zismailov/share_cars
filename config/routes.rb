Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # translated routes by the route_translator gem
  localized do
    resources :trips, except: [:destroy] do
      member do
        get "confirm"
        get "delete"
        get "points"
      end
      resources :messages
    end
    get "search", to: "search#index"

    PagesController::STATIC_PAGES.each do |page|
      get page, to: "pages##{page}"
    end
  end

  resources :geonames do
    collection do
      get "autocomplete"
    end
  end

  root to: "homes#index"
end
