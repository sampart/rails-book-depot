Rails.application.routes.draw do
  resources :orders
  post 'orders/:id/ship_it', to: 'orders#ship_it', as: 'order_ship_it'
  resources :line_items
  post 'line_items/:id/decrement', to: 'line_items#decrement', as: 'line_items_decrement'
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
