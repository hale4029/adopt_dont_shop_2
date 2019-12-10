class FavoritesController < ApplicationController

  def index
    @app_pets = Favorite.find_approved_adoption_pets
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
    flash[:notice] = "#{pet.name} was added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    @favorites.remove_pet(pet.id)
    session[:favorites] = @favorites.contents
    flash[:notice] = "#{pet.name} was removed from your favorites."
    redirect_back(fallback_location: "/favorites")
  end

  def destroy_all
    @favorites.remove_all
    session[:favorites] = @favorites.contents
    flash[:notice] = "All pets were removed to your favorites."
    redirect_back(fallback_location: "/favorites")
  end


end
