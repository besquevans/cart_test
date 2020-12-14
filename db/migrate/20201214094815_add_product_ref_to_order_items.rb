class AddProductRefToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :product, foreign_key: true, index: true
  end
end
