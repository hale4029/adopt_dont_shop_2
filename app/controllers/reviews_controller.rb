class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)
    if review.save
      flash[:success] = 'Review created!'
      @shelter.reviews.create(review_params)
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash.now[:error] = 'Review not created. Please complete required fields.'
      render :new
    end
  end

  def edit
    @shelter_id = params[:shelter_id]
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    if @review.update(review_params)
      flash[:success] = 'Review updated!'
      redirect_to "/shelters/#{@review.shelter_id}"
    else
      flash.now[:error] = 'Review not saved. Please complete required fields.'
      @shelter_id = params[:shelter_id]
      render :edit
    end
  end

  def destroy
    review = Review.destroy(params[:review_id])
    shelter = Shelter.find(params[:shelter_id])
    review.destroy
    flash[:success] = 'Review deleted!'
    redirect_to "/shelters/#{review.shelter_id}"
  end

private
  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
