class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    @order_items = @order.order_items
  end

  def create
    ActiveRecord::Base.transaction do
      @order = current_user.orders.build(email: order_params[:email])
      order_total = 0

      order_params[:order_items].to_h.each do |item|
        product = Product.find(item.last[:product_id])
        product.stock.update!(amount: product.stock.amount - item.last[:amount].to_i)
        @order.order_items.build(item.last)
        order_total += item.last[:value].to_i * item.last[:amount].to_i
      end
      @order.update!(total: order_total)

      current_user.cart.cart_items = []
      redirect_to(orders_path, notice: "Order create success!")
    end
  rescue ActiveRecord::RecordInvalid => @exception
    @cart_items = current_cart.cart_items
    flash.now[:alert] = "Order create false!"
    render template: "products/my_cart"
  end

  def update_stock(option)
    products = Product.where(id: option[:product_ids])

  end

  private

  def order_params
    params.require(:order).permit(:email, order_items: [:name, :value, :amount, :product_id])
  end
end
