class AddDefaultQuantityToCartItems < ActiveRecord::Migration[7.2]
  def change
    change_column_default :cart_items, :quantity, 0
  end
end
