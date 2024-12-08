class AddCommentToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :comment, :text
  end
end
