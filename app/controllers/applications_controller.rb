class ApplicationsController < ApplicationController

  def index
    @pets = @favorites.favorite_pets
  end

  def create
    app = Application.create(app_params)
    pets = params[:favorite_ids].map { |id| Pet.find(id) }
    app.pets << pets
    pets.each { |pet| @favorites.remove_pet(pet.id) }
    app.update_adoption_status(pets)
    flash[:success] = "Your application was submitted."
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
