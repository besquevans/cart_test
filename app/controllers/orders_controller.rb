class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def create
    ActiveRecord::Base.transaction do
      @order = current_user.orders.build(email: order_params[:email])

      order_params[:order_items].to_h.each do |item|
        product = Product.find(item.last[:product_id])
        product.stock.update!(amount: product.stock.amount - item.last[:amount].to_i)
        @order.order_items.build(item.last)
      end

      if @order.save
        current_user.cart.cart_items = []
        redirect_to(orders_path, notice: "Order create success!")
      else
        @cart_items = current_cart.cart_items
        flash.now[:alert] = "Order create false!"
        render template: "products/my_cart"
      end
    end
  end

  def update_stock(option)
    products = Product.where(id: option[:product_ids])

  end

  private

  def order_params
    params.require(:order).permit(:email, order_items: [:name, :value, :amount, :product_id])
  end
end