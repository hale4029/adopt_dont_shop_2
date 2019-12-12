require 'rails_helper'

describe Shelter, type: :model do
  describe "validations of shelter table" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  describe "model tests" do
    before :each do
      @shelter_1 = Shelter.create(name: "Save Cats",
                                address: "123 Pine",
                                city: "Denver",
                                state: "Colorado",
                                zip: 80112)
      @shelter_2 = Shelter.create(name: "Save Dogs",
                                address: "123 Pine",
                                city: "Denver",
                                state: "Colorado",
                                zip: 80112)
      @pet_1 = @shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Jersey",
                          approximate_age: "10",
                          sex: "Male")
      @pet_2 = @shelter_2.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Hershey",
                          approximate_age: "10",
                          sex: "Female")
      @app_1 = Application.create(name: 'Harrison Levin',
                                  address: '1234 Lame Street',
                                  city: 'Denver',
                                  state: 'CO',
                                  zip: '80211',
                                  phone: '720-111-2222',
                                  description: 'I love all of these pets.')
      @app_1.pets << [@pet_1]
    end

    it "find_shelters_with_pets_under_adoption" do
      ApplicationPet.approve_status(@pet_1.id, @app_1.id)
      bool = Shelter.find_shelters_with_pets_under_adoption(@shelter_1)
      expect(bool).to eq(false)
      bool = Shelter.find_shelters_with_pets_under_adoption(@shelter_2)
      expect(bool).to eq(true)
    end

    it "avg_review" do
    end

    it "number_of_apps_on_file" do
    end

    it "pet_count" do
    end
  end
end
