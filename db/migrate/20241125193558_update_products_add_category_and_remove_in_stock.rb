class UpdateProductsAddCategoryAndRemoveInStock < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :category, :string

    # Remove the in_stock column
    remove_column :products, :stock_quantity, :boolean
  end
end
