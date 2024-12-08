class CartItemsController < ApplicationController
  before_action :authenticate_user!  # Require login for carts actions
  before_action :set_cart_item, only: [:increase_quantity, :decrease_quantity]

  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    current_cart = get_or_create_cart
    cart_item = current_cart.cart_items.find_or_initialize_by(product: product)

    cart_item.quantity += quantity  # Update the quantity
    if cart_item.save
      redirect_to cart_path, notice: "Product added to carts."
    else
      redirect_to product_path, alert: "Failed to add product to carts."
    end
  end

  def increase_quantity
    @cart_item.increment!(:quantity)
    redirect_to cart_path
  end

  def decrease_quantity
    if @cart_item.quantity > 1
      @cart_item.decrement!(:quantity)
    else
      @cart_item.destroy
      flash[:notice] = "Item removed from cart."
    end
    redirect_to cart_path
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def get_or_create_cart
    current_user.cart || current_user.create_cart
  end
end