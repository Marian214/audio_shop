class AddDeliveryAddressToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :delivery_address, :string
  end
end
