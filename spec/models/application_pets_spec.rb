require "rails_helper"

describe ApplicationPet, type: :model do
  
  describe "validations of application_pets table" do
    it { should validate_presence_of :application_id }
    it { should validate_presence_of :pet_id }
    it { should validate_presence_of :status }
  end
end
