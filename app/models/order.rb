class Order < ApplicationRecord
  validates :email, presence: true

  belongs_to :user
  has_many :order_items, dependent: :destroy
end
