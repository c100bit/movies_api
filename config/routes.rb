Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :movies
      resources :countries, only: [ :index ]
      resources :genres, only: [ :index ]
    end
  end

end
