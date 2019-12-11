class PetsController < ApplicationController

  def index
    if params[:adoptable] == "true"
      @pets = Pet.where(adoption_status: 'Adoptable')
    elsif params[:adoptable] == "false"
      @pets = Pet.where(adoption_status: 'Pending Adoption')
    else
      @pets = Pet.order(:adoption_status)
    end
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    pet = @shelter.pets.create(pet_params)
    if pet.save
      flash[:success] = 'Pet created!'
      redirect_to "/shelters/#{params[:shelter_id]}/pets"
    else
      flash.now[:error] = pet.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @shelter = Shelter.find(params[:shelter_id])
    if params[:adoptable] == "true"
      @pets = @shelter.pets.where(adoption_status: 'Adoptable')
    elsif params[:adoptable] == "false"
      @pets = @shelter.pets.where(adoption_status: 'Pending Adoption')
    else
      @pets = @shelter.pets.order(:adoption_status)
    end
  end

  def show_pet
    @pet = Pet.find(params[:id])
    open_apps = @pet.application_pets
    app_ids = open_apps.map do |app|
      if app.status == "Approved"
        app.application_id
      end
    end
    @apps = Application.find_multiple_applicants(app_ids).flatten
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    if pet.save
      flash[:success] = 'Pet updated!'
      redirect_to "/pets/#{pet.id}"
    else
      flash[:error] = pet.errors.full_messages.to_sentence
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    if Pet.find_pets_with_approved_application(pet)
      Pet.destroy(params[:id])
      redirect_to "/pets"
    else
      flash[:error] = "Unable to delete pet. Approved application on file."
      redirect_back(fallback_location: "/pets")
    end
  end

  def change_adoption_status
    pet = Pet.find(params[:id])
      if pet.adoption_status == "Adoptable"
        status = "Pending Adoption"
      else
        status = "Adoptable"
      end
    pet.update({adoption_status: status})
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

private
  def pet_params
    params.permit(:name,
                  :image,
                  :description,
                  :sex,
                  :approximate_age)
  end
end
