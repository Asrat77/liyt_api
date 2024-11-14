Rails.application.routes.draw do
  resources :orders do
    collection do
      get 'get_price', to: 'orders#get_price'
    end
    member do
      post 'complete', to: 'orders#complete'
    end
  end
  resources :drivers
  resources :users
  get 'drivers/:driver_id/orders', to: 'orders#get_orders_by_driver'
  get 'users/:user_id/orders', to: 'orders#get_orders_by_user'
  post 'orders/:order_id/accept/:driver_id', to: 'orders#accept'
  post "/login", controller: :access, action: :login
  post "/signup", controller: :access, action: :signup
  get "/location/:name", to: "orders#location", as: "location"
  get "/orders/:order_id/accept/:driver_id", to: "orders#accept"
  get "/get_price/:origin/:destination", to: "orders#get_price", as: "get_price"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
