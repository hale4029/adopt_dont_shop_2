class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)

    if review.save
      @shelter.reviews.create(review_params)
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash.now[:error] = 'Review not created. Please complete required fields.'
      render :new
    end
  end

private
  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
