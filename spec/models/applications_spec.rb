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
  end

  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "methods" do
    it "can update adoption status of pet" do

      @shelter_1 = Shelter.create(name:    "Reptile Room",
                                  address: "2364 Desert Lane",
                                  city:    "Denver",
                                  state:   "CO",
                                  zip:     "80211")

      @app_1 = Application.create(name: 'Harrison Levin',
                                  address: '1234 Lame Street',
                                  city: 'Denver',
                                  state: 'CO',
                                  zip: '80211',
                                  phone: '720-111-2222',
                                  description: 'I love all of these pets.')

      @pet_1 = Pet.create(image:      "https://www.lllreptile.com/uploads/images/StoreInventoryImage/14570/large",
                          name:       "Alfredo",
                          description:       "I'm a white ball python!",
                          approximate_age:        "4",
                          sex:        "female",
                          adoption_status:     "adoptable",
                          shelter_id: @shelter_1.id)

      @pet_2 = Pet.create(image:     "https://www.geek.com/wp-content/uploads/2019/04/pantherchameleon1-625x352.jpg",
                         name:       "Poppy",
                         description:       "I'm a panther chameleon! I am not very social but am fun to look at.",
                         approximate_age:        "2",
                         sex:        "male",
                         adoption_status:     "adoptable",
                         shelter_id: @shelter_1.id)

      pets = [@pet_1, @pet_2]
      
    end
  end
end
