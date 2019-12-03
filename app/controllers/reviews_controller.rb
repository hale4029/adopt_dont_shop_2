class ReviewsController < ApplicationController
  def show
    @reviews = Review.where(shelter_id: params[:id])
  end

end
