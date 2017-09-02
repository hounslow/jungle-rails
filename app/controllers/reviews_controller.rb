class ReviewsController < ApplicationController
  before_action :require_user

  def require_user
    if !current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_url # halts request cycle
    end
  end

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

  def destroy
    Review.find(params[:id]).destroy
    redirect_to :back
  end

  private
  def review_params
    params.require(:review).permit(
    :description,
    :rating
    )
  end

end
