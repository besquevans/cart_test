class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user, :admin?, :cart_items
  before_action :authorized

  def current_user
    if session[:user_id]
      @user ||= User.find(session[:user_id])  #||=避免多餘查詢
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    redirect_to sign_in_users_path unless logged_in?
  end

  def current_cart
    @cart ||= Cart.where(user_id: current_user.id).first_or_create
  end

  def cart_items
    cart_items = current_cart.cart_items.includes(product: :stock)
  end
end
