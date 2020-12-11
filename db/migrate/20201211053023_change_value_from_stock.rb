class ChangeValueFromStock < ActiveRecord::Migration[6.0]
  def change
    rename_column :stocks, :value, :amount
    change_column :stocks, :amount, :integer, default: 0
  end
end
