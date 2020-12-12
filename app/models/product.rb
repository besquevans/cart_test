class Product < ApplicationRecord
  has_one :stock    #庫存數量
  has_many :fav_products, dependent: :destroy    #被加入最愛次數
  has_many :cart_items, dependent: :destroy      #被加入購物車次數
end
