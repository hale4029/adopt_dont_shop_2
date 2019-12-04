class FavoriteController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    pet = Pet.find(params[:id])
    pet_id_str = pet.id.to_s
    session[:favorite] ||= Hash.new(0)
    session[:favorite][pet_id_str] ||= 0
    session[:favorite][pet_id_str] = session[:favorite][pet_id_str] + 1
    flash[:notice] = "#{pet.name} added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end
end
