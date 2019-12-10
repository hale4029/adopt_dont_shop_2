class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates_presence_of :status,
                        :pet_id,
                        :application_id

def self.pending_status
  update({status: "Pending Adoption"})
end

# def self.find_pets_in_applications
#   ApplicationPet.where(status: "Pending Adoption")
#   #apps = Application.all
#   #apps.map { |app| app.pets }.flatten
# end


end
