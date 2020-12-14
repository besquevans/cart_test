class Product < ApplicationRecord
  has_one :stock    #庫存數量
  has_many :fav_products, dependent: :destroy    #被加入最愛
  has_many :cart_items, dependent: :destroy      #被加入購物車
  has_many :order_items, dependent: :nullify     #被加入訂單
end
