class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items.order(:created_at)  # Якщо кошик існує, то замовлення за датою створення
  end

  def add
    product = Product.find(params[:product_id])

    # Перевірка чи є кошик у користувача, і якщо немає - створити новий
    cart = current_user.cart || current_user.create_cart

    # Перевірка наявності товару в кошику
    cart_item = cart.cart_items.find_by(product: product)

    if cart_item
      # Оновлення кількості, якщо товар вже є
      cart_item.update(quantity: cart_item.quantity + params[:quantity].to_i)
    else
      # Додавання нового товару до кошика
      cart.cart_items.create!(product: product, quantity: params[:quantity].to_i)
    end

    redirect_to cart_path(cart), notice: 'Продукт додано до кошика!'
  end

  def remove
    # Видалення товару з кошика
    cart_item = current_user.cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: "Товар видалено з кошика"
  end

  def clear
    # Очищення всіх товарів в кошику
    current_user.cart.cart_items.destroy_all
    redirect_to cart_path, notice: "Ваш кошик очищено"
  end

  def checkout
    @cart_items = @cart.cart_items.order(:created_at) # Додайте це для доступу до елементів у вигляді
    @order = Order.new(user: current_user)
  end


  private

  # Забезпечуємо наявність кошика для користувача перед кожним екшеном
  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
