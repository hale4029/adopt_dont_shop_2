class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :phone,
                        :description,
                        :status

def update_adoption_status(pets)
  pets.each do |pet|
    if pet.adoption_status == "adoptable"
      status = "Pending Adoption"
    else
      status = "Adoptable"
    end
    pet.update({adoption_status: status})
    pet.save
  end
end

def self.find_pets_in_applications
  apps = Application.all
  apps.map { |app| app.pets }.flatten
end

def self.find_pets(ids)
  ids.map { |id| Pet.find(id) }
end

def self.remove_all_pets_from_favorites(pets, favorites)
  pets.each { |pet| favorites.remove_pet(pet.id) }
end

def self.find_applicant(pet)
  Application.select(:name, :id).joins(:pets).where("pets.id = #{pet.id}")
end

end
