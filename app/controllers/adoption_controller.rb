class AdoptionController < ApplicationController

  def index
    @pets = @favorites.favorite_pets
  end

end
