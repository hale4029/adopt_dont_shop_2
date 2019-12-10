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
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.create(pet_params)
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
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
    #ApplicationPet.select(:application_id).where("pet_id = #{@pet.id} AND status = 'Adoption Pending'")
    open_apps = @pet.application_pets
    app_ids = open_apps.map do |app|
      if app.status == "Pending Adoption"
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
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
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
