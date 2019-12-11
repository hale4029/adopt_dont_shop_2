class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets

  validates_presence_of :image,
                        :name,
                        :approximate_age,
                        :sex,
                        :adoption_status,
                        :description

def change_adoption_status_to_pending
  update({adoption_status: "Pending Adoption"})
end

def change_adoption_status_to_adoptable
  update({adoption_status: "Adoptable"})
end

def self.find_pets_with_approved_application(pet)
  pet_status = ApplicationPet.where("pet_id = #{pet.id} AND status = 'Approved'")
  pet_status.length == 0 ? true : false
end

end
