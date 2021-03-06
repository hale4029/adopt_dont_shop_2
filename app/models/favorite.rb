class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(id)
      @contents[id.to_s] = 1
  end

  def remove_pet(id)
    @contents.delete(id.to_s)
  end

  def favorite_pets
    @contents.map do |pet_id, quantity|
      Pet.find(pet_id)
    end
  end

  def remove_all
    @contents.each { |key, value| remove_pet(key) }
  end

  def self.find_approved_adoption_pets
    pets_pending = ApplicationPet.where(status: "Approved")
    pets_pending.map { |app_pet| Pet.find(app_pet.pet_id) }
  end

  def self.find_pending_adoption_pets
    pets_pending = ApplicationPet.where(status: "Pending")
    pets_pending.map { |app_pet| Pet.find(app_pet.pet_id) }.uniq
  end
end
