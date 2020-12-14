class AddTotalToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :total, :integer
    remove_column :cart_items, :amount
  end
end
