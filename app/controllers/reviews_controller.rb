class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.product_id = params[:product_id]

    if @review.save
      redirect_to product_url(params[:product_id]), notice: "Review created"
    else
      redirect_to({:controller => 'products', :action => 'show', :id => params[:product_id]}, notice: "Review not made")
    end
  end

  private
  def review_params
    params.require(:review).permit(
    :description,
    :rating
    )
  end
end
