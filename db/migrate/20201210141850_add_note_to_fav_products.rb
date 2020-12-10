class AddNoteToFavProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :fav_products, :note, :string
  end
end
