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

  def avg_review
    result = Review.where("shelter_id = #{self.id}").average(:rating)
    result == nil ? 0 : result.round(1)
  end

  def number_of_apps_on_file
    pet_ids = self.pets.map { |pet| pet.id }
    applications = pet_ids.reduce([]) do |acc, id|
      acc << ApplicationPet.where("pet_id = #{id}")
      acc.reject(&:empty?)
    end
    applications.flatten.length
  end

  def pet_count
    self.pets.count
  end

end
