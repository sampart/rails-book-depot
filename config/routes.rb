Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller 'sessions' do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :users
  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [ :index, :update ]

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index'
    post '/' => 'store#index', as: 'store_index_post'
  end
  post 'orders/:id/ship_it', to: 'orders#ship_it', as: 'order_ship_it'
  post 'line_items/:id/decrement', to: 'line_items#decrement', as: 'line_items_decrement'
  
  if Rails.env.test?
    get 'test/raise_error', to: 'application#raise_error', as: 'test_raise_error'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
