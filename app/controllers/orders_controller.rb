class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @cart = current_user.cart
    @cart_items = @cart.cart_items

    # If the cart is empty, show an alert and don't process the order
    if @cart_items.empty?
      flash.now[:alert] = "Ваш кошик порожній!"
      render :contacts and return
    end

    # Calculate the total price for the order
    @order.total_price = @cart_items.sum { |item| item.quantity * item.product.price }

    # Build order_items from the cart_items
    @cart_items.each do |item|
      @order.order_items.build(product: item.product, quantity: item.quantity, price: item.product.price)
    end

    # Save the order and empty the cart if successful
    if @order.save
      @cart.cart_items.destroy_all
      redirect_to root_path, notice: "Ваше замовлення успішно оформлено!"
    else
      flash.now[:alert] = "Не вдалося оформити замовлення. Перевірте введені дані."
      render :'carts/checkout'
    end
  end

  private

  # Permitted parameters for order creation
  def order_params
    params.require(:order).permit(
      :name, :email, :phone, :address, :delivery_method,
      :payment_method, :delivery_address, :comment, :total_price
    )
  end
end