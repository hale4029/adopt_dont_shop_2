class ApplicationPetsController < ApplicationController

  def update
    app_pet_id = ApplicationPet.where("pet_id = #{params[:pet_id]} AND application_id = #{params[:app_id]}").approve_status
    app_pet_id.first.save
    pet = Pet.find(params[:pet_id])
    pet.change_adoption_status
    pet.save
    redirect_to "/pets/#{params[:pet_id]}"
  end

end
