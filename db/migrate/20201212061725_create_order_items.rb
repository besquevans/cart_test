class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.string :name
      t.string :value
      t.integer :amount
      t.references :order, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
