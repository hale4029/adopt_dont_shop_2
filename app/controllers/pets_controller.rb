class PetsController < ApplicationController
  def index
    pets = Pet.all
    @pets = pets.sort_by { |pet| pet.adoption_status }
    if params[:adoptable] == "true"
      @pets.select! { |pet| pet.adoption_status == "adoptable" }
    elsif params[:adoptable] == "false"
      @pets.select! { |pet| pet.adoption_status == "adoption-pending" }
    else
      @pets
    end
  end

  def show
    @shelter = Shelter.find(params[:shelter_id])
    pets = @shelter.pets
    @pets = pets.sort_by { |pet| pet.adoption_status }
    if params[:adoptable] == "true"
      @pets.select! { |pet| pet.adoption_status == "adoptable" }
    elsif params[:adoptable] == "false"
      @pets.select! { |pet| pet.adoption_status == "adoption-pending" }
    else
      @pets
    end
  end

  def show_pet
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.create({
      name: params[:name],
      image: params[:image],
      description: params[:description],
      sex: params[:sex],
      approximate_age: params[:approximate_age]
      })
    pet.save
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update({
      name: params[:name],
      image: params[:image],
      description: params[:description],
      sex: params[:sex],
      approximate_age: params[:approximate_age]
      })
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def change_adoption_status
    pet = Pet.find(params[:id])
    if pet.adoption_status == "adoptable"
      status = "adoption-pending"
    else
      status = "adoptable"
    end
    pet.update({
      adoption_status: status
      })
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

end
