class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates_presence_of :status,
                        :pet_id,
                        :application_id

def self.approve_status
  update({status: "Approved"})
end

def self.pending_status
  update({status: "Pending"})
end

end
