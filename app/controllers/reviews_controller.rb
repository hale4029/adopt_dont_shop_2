class ReviewsController < ApplicationController
  def index
    @reviews = Review.where(shelter_id: params[:shelter_id])
  end

end
