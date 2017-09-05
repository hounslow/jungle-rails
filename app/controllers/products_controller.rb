class ProductsController < ApplicationController

  def index
    @products = Product.order(created_at: :desc).all
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews.order(created_at: :desc)
    @review = Review.new
  end

end
