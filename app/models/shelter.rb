class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def self.find_shelters_with_pets_under_adoption(shelter)
    approved_pets = shelter.pets.map do |pet|
      ApplicationPet.where("pet_id = #{pet.id} AND status = 'Approved'")
    end
    approved_pets.reject(&:empty?).length == 0 ? true : false
  end

end
