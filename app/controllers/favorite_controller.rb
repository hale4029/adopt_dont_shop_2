class FavoriteController < ApplicationController

  def update
    pet = Pet.find(params[:id])
    @favorites.add_pet(pet.id)
    session[:favorite] = @favorites.contents
    flash[:notice] = "#{pet.name} added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

end
