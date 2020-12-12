class RemoveNameAndValueFromCartItem < ActiveRecord::Migration[6.0]
  def change
    remove_column :cart_items, :name
    remove_column :cart_items, :value
  end
end
