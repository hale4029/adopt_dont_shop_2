class ReviewsController < ApplicationController
<<<<<<< HEAD

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.create(review_params)
    redirect_to "/shelters/#{@shelter.id}"
  end
=======
>>>>>>> 66d634945e8f926307d4858b289dbfbc2f770ba2

private
  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
