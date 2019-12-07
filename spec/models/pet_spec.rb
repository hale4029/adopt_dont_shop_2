require "rails_helper"

describe Pet, type: :model do
  describe "validations of pets table" do
    it { should validate_presence_of :image }
    it { should validate_presence_of :name }
    it { should validate_presence_of :approximate_age }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :adoption_status }
    it { should validate_presence_of :description }
  end

  describe "relationships" do
    it { should belong_to :shelter }
    it { should have_many :application_pets }
    it { should have_many(:applications).through(:application_pets) }
  end
end
