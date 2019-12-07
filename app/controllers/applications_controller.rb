class ApplicationsController < ApplicationController

  def index
    @pets = @favorites.favorite_pets
  end

  def create
    app = Application.new(app_params)
    app.save
    redirect_to "/favorites"
  end

  private
    def app_params
      params.permit(:name,
                    :address,
                    :city,
                    :state,
                    :zip,
                    :phone,
                    :description)
    end
end
