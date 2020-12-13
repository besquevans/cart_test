class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def create
    cart = current_user.cart

    ActiveRecord::Base.transaction do
      order = current_user.orders.create!(
        email: params[:email]
      )

      Order.last.order_items.create!(
        cart.cart_items.map do |item|
          {
            name: item.product.name,
            value: item.product.value,
            amount: item.amount
          }
        end
      )

      cart.cart_items = []
    end

    redirect_to(orders_path)
  end
end
