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

  describe "model test" do
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
      @app_1 = Application.create(name: 'Harrison Levin',
                                  address: '1234 Lame Street',
                                  city: 'Denver',
                                  state: 'CO',
                                  zip: '80211',
                                  phone: '720-111-2222',
                                  description: 'I love all of these pets.')
      @app_1.pets << [@pet_1, @pet_2]
    end

    it "change_adoption_status_to_pending" do
      expect(@pet_1.adoption_status).to eq("Adoptable")
      @pet_1.change_adoption_status_to_pending
      expect(@pet_1.adoption_status).to eq("Pending Adoption")
    end

    it "change_adoption_status_to_adoptable" do
      @pet_1.change_adoption_status_to_pending
      expect(@pet_1.adoption_status).to eq("Pending Adoption")
      @pet_2.change_adoption_status_to_adoptable
      expect(@pet_2.adoption_status).to eq("Adoptable")
    end

    it "find_pets_with_approved_application" do
    end
  end
end
