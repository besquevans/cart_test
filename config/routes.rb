Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index] do
    collection do
      get :my_cart
      get :my_fav_products
      get :my_orders
      get :my_order_detail
    end

    member do
      post :add_to_cart
      post :add_fav_products
    end
  end

  resources :users, only: [:create] do
    collection do
      get :sign_in
      get :sign_up
      post :login
      delete :sign_out
    end
  end
end
