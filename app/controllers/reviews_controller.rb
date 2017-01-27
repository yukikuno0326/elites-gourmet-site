class ReviewsController < ApplicationController
  def create
    review = Review.new
    review.attributes = input_params
    review.user_id = current_user.id
    if review.valid?
      review.save!
      flash[:notice] = I18n.t('review.created')
      redirect_to restaurant_path(review.restaurant_id)
    else
      flash[:alert] = review.errors.full_messages
      redirect_to request.referer
    end
  end

  def destroy
    review = Review.find(params[:id])
    restaurant_id = review.restaurant_id
    review.destroy!
    flash[:notice] = I18n.t('review.deleted')
    redirect_to restaurant_path(restaurant_id)
  end

  private

  def input_params
    params.require(:review).permit(:restaurant_id, :rank, :body)
  end
end
