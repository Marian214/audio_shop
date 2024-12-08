class AddTotalPriceToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :total_price, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
