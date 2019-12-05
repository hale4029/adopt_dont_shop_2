class FavoritesController < ApplicationController

  def index
    pet_ids = @favorites.contents.keys
    @pets = pet_ids.reduce([]) do |acc, key|
      acc << Pet.find(key.to_i)
      acc
    end
  end

  def update
    pet = Pet.find(params[:id])
    @favorites.add_pet(pet.id)
    session[:favorites] = @favorites.contents
    flash[:notice] = "#{pet.name} added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end



end
