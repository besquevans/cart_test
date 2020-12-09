class User < ApplicationRecord
  has_many :orders
  has_many :fav_products
  has_one :cart
end
