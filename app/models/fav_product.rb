class FavProduct < ApplicationRecord
  validates :product_id, uniqueness: true

  belongs_to :user
  belongs_to :product
end
