class AddDeliveryAndPaymentMethodsToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :delivery_method, :string
    add_column :orders, :payment_method, :string
  end
end
