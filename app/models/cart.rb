class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy   #購物車內商品 移除購物車時一併移除
end
