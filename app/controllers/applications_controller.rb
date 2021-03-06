class ApplicationsController < ApplicationController

  def index
  end

  def new
    @pets = @favorites.favorite_pets
  end

  def create
    app = Application.new(app_params)
    if app.save
      pets = params[:favorite_ids].map { |id| Pet.find(id) }
      app.pets << pets
      pets.each { |pet| @favorites.remove_pet(pet.id) }
      flash[:success] = "Your application was submitted."
      redirect_to "/favorites"
    else
      flash.now[:error] = 'Application not submitted. Please complete required fields.'
      @pets = @favorites.favorite_pets
      render :new
    end
  end

  def show
    @app = Application.find(params[:id])
  end

  def pet_apps     
    @pet = Pet.find(params[:id])
    @applicants = Application.find_applicants(@pet)
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
