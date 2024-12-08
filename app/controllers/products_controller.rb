class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @category = params[:category]

    if params[:category].present?
      @products = Product.where(category: params[:category])
    else
      @products = Product.all
    end

    if params[:query].present?
      @products = @products.where("name LIKE ? OR category LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product
    else
      render 'new', status: 422
    end
  end
  
  private def product_params
    params.require(:product).permit(:name, :description, :price, :category, :image)
  end
end