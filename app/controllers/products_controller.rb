class ProductsController < ApplicationController
  before_action :find_cart, only: [:index, :my_cart, :add_to_cart, :remove_from_cart]
  before_action :find_fav_products, only: [:index, :my_fav, :add_to_fav, :remove_from_fav]

  def index
    @products = Product.includes(:stock)
    @fav_products_ids = @fav_products.pluck(:product_id)
    @cart_items_ids = @cart.cart_items.pluck(:product_id)
  end

  # cart products

  def my_cart
    @cart_items = @cart.cart_items.includes(:product)
  end

  def add_to_cart
    product = Product.find_by(id: params[:id])
    amount = params[:amount].to_i

    if !product  #找不到商品時返回
      redirect_back(fallback_location:"/", alert: "Product not found!")
    elsif product.stock.amount < amount  #庫存不夠時返回
      redirect_back(fallback_location:"/", alert: "STOCK not enough!")
    else
      product.stock.update(amount: (product.stock.amount - amount ))
      @cart.cart_items.create(product_id: product.id, amount: amount)
      redirect_to(products_path, notice: "Add #{product.name} to Cart!")
    end
  end

  def remove_from_cart
    cart_item = @cart.cart_items.find_by(product_id: params[:id]).destroy
    product = Product.find_by(id: params[:id])
    product.stock.update(amount: (product.stock.amount + cart_item.amount ))
    redirect_back(fallback_location:"/", notice: "Remove #{product.name} from Cart!")
  end


  # favorite products

  def my_fav
  end

  def add_to_fav
    @fav_products.create(product_id: params[:id], note: params[:note])
    redirect_to(products_path, notice: "note: #{params[:note]}" )
  end

  def remove_from_fav
    @fav_products.find_by(product_id: params[:id]).destroy
    redirect_back(fallback_location:"/", notice: "Remove #{Product.find_by(id: params[:id]).name} from Favorites")
  end

  private

  def find_cart
    @cart ||= Cart.where(user_id: current_user.id).first_or_create
  end

  def find_fav_products
    @fav_products = current_user.fav_products.includes(:product)
  end
end
