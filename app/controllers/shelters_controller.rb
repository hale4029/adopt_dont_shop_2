class SheltersController < ApplicationController
  def index
    shelters = Shelter.all
    if params[:sorted] == "false"
      shelters
    elsif params[:sorted] == "true"
      shelters = shelters.sort_by do |shelter|
        shelter.pets.count
      end.reverse
    elsif params[:alpha] == "true"
      shelters = shelters.sort_by do |shelter|
        shelter.name
      end
    else
      shelters
    end
    x = params[:sorted] == "true" ? "true" : "false"
    y = params[:alpha] == "true" ? "true" : "false"
    @helper = [shelters, x, y]
  end

  def show
    @shelter = Shelter.find(params[:id])
    #require "pry"; binding.pry
    @reviews = Review.where(shelter_id: params[:id])
    {shelters: @shelters, reviews: @reviews}
  end

  def new
  end

  def create
    shelter = Shelter.create({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip]
      })
    shelter.save
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip]
      })
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end


end
