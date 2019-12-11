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

  describe "model methods" do
    before :each do
      @shelter_1 = Shelter.create(name: "Save Cats",
                                address: "123 Pine",
                                city: "Denver",
                                state: "Colorado",
                                zip: 80112)

      @pet_1 = @shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Jersey",
                          approximate_age: "10",
                          sex: "Male")
      @pet_2 = @shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Hershey",
                          approximate_age: "10",
                          sex: "Female")
    end

    it "find pets" do
      pet_objects = Application.find_pets([@pet_1.id, @pet_2.id])
      expect(pet_objects).to eq([@pet_1, @pet_2])
    end

    it "find applicants" do
      app_1 = Application.create(name: 'Harrison Levin',
                                  address: '1234 Lame Street',
                                  city: 'Denver',
                                  state: 'CO',
                                  zip: '80211',
                                  phone: '720-111-2222',
                                  description: 'I love all of these pets.')

      app_1.pets << [@pet_1, @pet_2]
      name_id = Application.find_applicants(@pet_1)
      expect(name_id.first.name).to eq("Harrison Levin")
      expect(name_id.first.id).to eq(app_1.id)
    end

    it "find multiple applicants" do
    end

    it "button_logic" do
    end
  end
end
