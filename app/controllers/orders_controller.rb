class OrdersController < ApplicationController
  before_action :current_cart, only: [:create]

  def index
    @orders = current_user.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    @order_items = @order.order_items
  end

  def create
    @order = current_user.orders.build(email: order_params[:email])
    order_total = 0

    ActiveRecord::Base.transaction do
      order_params[:order_items].to_h.each do |item|
        product = Product.find(item.last[:product_id])
        product.stock.update!(amount: product.stock.amount - item.last[:amount].to_i)
        @order.order_items.build(item.last)
        order_total += item.last[:value].to_i * item.last[:amount].to_i
      end
      @order.update!(total: order_total)

      current_cart.cart_items = []
      redirect_to(orders_path, notice: "Order create success!")
    end
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = "Order create false!"
    render template: "products/my_cart"
  end

  private

  def order_params
    params.require(:order).permit(:email, order_items: [:name, :value, :amount, :product_id])
  end
end
