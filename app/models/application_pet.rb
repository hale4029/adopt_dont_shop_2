class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates_presence_of :status,
                        :pet_id,
                        :application_id

  def self.approve_status(pet_id, app_id)
    where("pet_id = #{pet_id} AND application_id = #{app_id}").update({status: "Approved"})
  end

  def self.pending_status(pet_id, app_id)
    where("pet_id = #{pet_id} AND application_id = #{app_id}").update({status: "Pending"})
  end
end
