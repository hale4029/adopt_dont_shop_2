class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :phone,
                        :description

  def self.find_pets(ids)
    ids.map { |id| Pet.find(id) }
  end

  def self.find_applicant(pet)
    Application.select(:name, :id).joins(:pets).where("pets.id = #{pet.id}")
  end

  def self.find_multiple_applicants(app_ids)
    app_ids.map { |id| Application.select(:name).where(id: id) }
  end

  def button_logic(pet, app_id)
    application_pet_status = ApplicationPet.where("pet_id = #{pet.id} AND status = 'Approved' AND application_id = #{app_id}")
    application_pet_status.length > 0 ? true : false
  end

end
