class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.create(review_params)
    redirect_to "/shelters/#{@shelter.id}"
  end

private
  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
