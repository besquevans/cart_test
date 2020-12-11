class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.integer :value
      t.references :product, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
