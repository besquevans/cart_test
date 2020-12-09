class CreateFavProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :fav_products do |t|
      t.references :user, index: true
      t.references :product, index: true
      t.timestamps
    end
  end
end
