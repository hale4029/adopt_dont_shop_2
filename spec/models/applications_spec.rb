require "rails_helper"

describe Application, type: :model do
  describe "validations of applications table" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :description }
    it { should validate_presence_of :status }
  end

  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end
end
