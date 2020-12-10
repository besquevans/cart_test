class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def my_cart
    @cart = current_user.cart
  end

  def add_to_cart
    product = Product.find_by(id: params[:id])
    if product
      product.stock.update(value: (product.stock.value - params[:number] )) #????
      @cart ||= Cart.where(user_id: current_user.id).first_or_create
      @cart.cart_items.create(product_id: product.id)
      redirect_to products_path, notice: "Success!"
    else
      redirect_back(fallback_location:"/")
    end
  end

  def add_fav_products
    current_user.fav_products.create(product_id: params[:id], note: params[:note])
    redirect_to products_path, notice: "<b>Success!</b> note: #{params[:note]}"
  end

  def my_fav_products
    @fav_products = current_user.fav_products
  end

  def create_order
    cart = Cart.find_by(id: params[:id])

    @order = Order.create(
      user_id: current_user.id,
      cart_id: cart.id,
      email: current_user.email
    )

    cart.destroy
  end

  def my_orders
    @orders = current_user.orders
  end

  def my_order_detail
    @order = Order.find_by(id: params[:id])
  end
end
