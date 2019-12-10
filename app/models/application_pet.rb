class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates_presence_of :status,
                        :pet_id,
                        :application_id

def self.pending_status
  update({status: "Pending Adoption"})
end

end
