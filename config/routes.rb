Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index] do
    collection do
      get :my_cart
      get :my_fav
      get :my_orders
      get :my_order_detail
    end

    member do
      post :add_to_cart
      delete :remove_from_cart
      post :add_to_fav
      delete :remove_from_fav
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
