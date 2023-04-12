Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :follows, only: [:create, :destroy]
      resources :clocks, only: [:create, :index]
      get "/clocks/user_sleep_records", to: "clocks#user_sleep_records"
    end
  end
end
