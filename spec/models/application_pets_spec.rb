require "rails_helper"

describe ApplicationPet, type: :model do

  describe "validations of application_pets table" do
    it { should validate_presence_of :application_id }
    it { should validate_presence_of :pet_id }
    it { should validate_presence_of :status }
  end

  describe "methods" do
    before(:each) do

      @shelter_1 = Shelter.create(name:    "Reptile Room",
                                  address: "2364 Desert Lane",
                                  city:    "Denver",
                                  state:   "CO",
                                  zip:     "80211")

      @pet_1 = Pet.create(image:      "https://www.lllreptile.com/uploads/images/StoreInventoryImage/14570/large",
                          name:       "Alfredo",
                          description:       "I'm a white ball python!",
                          approximate_age:        "4",
                          sex:        "female",
                          shelter_id: @shelter_1.id)

      @app_1 = Application.create(name: 'Harrison Levin',
                                  address: '1234 Lame Street',
                                  city: 'Denver',
                                  state: 'CO',
                                  zip: '80211',
                                  phone: '720-111-2222',
                                  description: 'I love all of these pets.')

      @app_pet = ApplicationPet.create(application_id: @app_1.id,
                                      pet_id: @pet_1.id)
    end

    it ".approve_status" do

      application = ApplicationPet.approve_status(@app_pet.pet_id, @app_pet.application_id)
      application.first.save
      expect(application.first.status).to eq("Approved")
    end
  end
end
