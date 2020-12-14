class ProductsController < ApplicationController
  before_action :current_cart, only: [:index, :my_cart, :add_to_cart, :remove_from_cart]
  before_action :find_fav_products, only: [:index, :my_fav, :add_to_fav, :remove_from_fav]
  before_action :find_product, only: [:add_to_cart, :remove_from_cart]

  def index
    @products = Product.includes(:stock).page(params[:page]).per(10)
    @fav_products_ids = @fav_products.pluck(:product_id)
    @cart_items_ids = current_cart.cart_items.pluck(:product_id)
  end

  # cart products

  def my_cart
    @cart_items = current_cart.cart_items.includes(:product)
    @total = @cart_items.pluck(:value).sum
    @order = Order.new
  end

  def add_to_cart
    if @product
      current_cart.cart_items.create(product_id: @product.id)
      redirect_to(products_path, notice: "Add #{@product.name} to Cart!")
    else
      redirect_back(fallback_location:"/", alert: "Product not found!") #找不到商品時返回
    end
  end

  def remove_from_cart
    cart_item = current_cart.cart_items.find_by(product_id: params[:id]).destroy
    redirect_back(fallback_location:"/", notice: "Remove #{@product.name} from Cart!")
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

  def find_fav_products
    @fav_products = current_user.fav_products.includes(:product)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
