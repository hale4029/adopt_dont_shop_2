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
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    if shelter.save
      flash[:success] = 'Shelter created!'
      redirect_to '/shelters'
    else
      flash.now[:error] = shelter.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    if shelter.save
      flash[:success] = 'Shelter updated!'
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:error] = shelter.errors.full_messages.to_sentence
      redirect_to "/shelters/#{params[:id]}/edit"
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if Shelter.find_shelters_with_pets_under_adoption(shelter)
      Shelter.destroy(params[:id])
      redirect_to "/shelters"
    else
      flash[:error] = "Unable to delete shelter. Approved application on file."
      redirect_back(fallback_location: "/shelters")
    end
  end

private
  def shelter_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip)
  end
end
