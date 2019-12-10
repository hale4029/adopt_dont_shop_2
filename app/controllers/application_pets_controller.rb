class ApplicationPetsController < ApplicationController

  def update
    if params[:status] == "false"
      app_pet_id = ApplicationPet.where("pet_id = #{params[:pet_id]} AND application_id = #{params[:app_id]}").pending_status
      app_pet_id.first.save
      pet = Pet.find(params[:pet_id])
      pet.change_adoption_status_to_adoptable
      pet.save
      redirect_to "/applications/#{params[:app_id]}"
    else
      app_pet_id = ApplicationPet.where("pet_id = #{params[:pet_id]} AND application_id = #{params[:app_id]}").approve_status
      app_pet_id.first.save
      pet = Pet.find(params[:pet_id])
      pet.change_adoption_status_to_pending
      pet.save
      redirect_to "/pets/#{params[:pet_id]}"
    end
  end

end
