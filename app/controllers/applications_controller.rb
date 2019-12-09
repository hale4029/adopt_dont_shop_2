class ApplicationsController < ApplicationController

  def index
    @apps = Application.all
  end

  def new
    @pets = @favorites.favorite_pets
  end

  def create
    app = Application.new(app_params)
    if app.save
      ids = params[:favorite_ids]
      pets = Application.find_pets(ids)
      app.pets << pets
      Application.remove_all_pets_from_favorites(pets, @favorites)
      app.update_adoption_status(pets)
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
    @applicants = Application.select(:name, :id).joins(:pets).where("pets.id = #{@pet.id}")
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
