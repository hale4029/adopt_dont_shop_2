require 'rails_helper'

RSpec.describe Favorite do

  describe "#total_count" do
    it "can calculate the total number of pets it holds" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 1
      })
      expect(favorites.total_count).to eq(2)
      favorites.add_pet(3)
      expect(favorites.contents).to eq({'1' => 1, '2' => 1, '3' => 1})
    end

    it "cannot add a pet more than once to favorites" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 1
      })
      expect(favorites.total_count).to eq(2)
      favorites.add_pet(1)
      favorites.add_pet(2)
      expect(favorites.contents).to eq({'1' => 1, '2' => 1})
    end

    it "remove pet" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 1
      })
      favorites.remove_pet(2)
      expect(favorites.contents).to eq({'1' => 1})
    end

    it "favorites pets" do
      shelter_1 = Shelter.create(name: "Save Cats",
                                address: "123 Pine",
                                city: "Denver",
                                state: "Colorado",
                                zip: 80112)

      pet_1 = shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Jersey",
                          approximate_age: "10",
                          sex: "Male")
      pet_2 = shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Hershey",
                          approximate_age: "10",
                          sex: "Female")

      favorites = Favorite.new({
        pet_1.id => 1,
        pet_2.id => 1
      })
      result = favorites.favorite_pets
      expect(result).to eq([pet_1, pet_2])
    end

    it "remove all" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 1
      })
      result = favorites.remove_all
      expect(result).to eq({})
    end

    it "find_pending_adoption_pets" do
      shelter_1 = Shelter.create(name: "Save Cats",
                                address: "123 Pine",
                                city: "Denver",
                                state: "Colorado",
                                zip: 80112)

      pet_1 = shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Jersey",
                          approximate_age: "10",
                          sex: "Male")
      pet_2 = shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Hershey",
                          approximate_age: "10",
                          sex: "Female")
      app_1 = Application.create(name: 'Harrison Levin',
                                  address: '1234 Lame Street',
                                  city: 'Denver',
                                  state: 'CO',
                                  zip: '80211',
                                  phone: '720-111-2222',
                                  description: 'I love all of these pets.')
      app_1.pets << [pet_1, pet_2]
      ApplicationPet.approve_status(pet_1.id, app_1.id)
      result = Favorite.find_approved_adoption_pets
      expect(result).to eq([pet_1])
    end

    it "find_approved_adoption_pets" do
      shelter_1 = Shelter.create(name: "Save Cats",
                                address: "123 Pine",
                                city: "Denver",
                                state: "Colorado",
                                zip: 80112)

      pet_1 = shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Jersey",
                          approximate_age: "10",
                          sex: "Male")
      pet_2 = shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                          name: "Hershey",
                          approximate_age: "10",
                          sex: "Female")
      app_1 = Application.create(name: 'Harrison Levin',
                                  address: '1234 Lame Street',
                                  city: 'Denver',
                                  state: 'CO',
                                  zip: '80211',
                                  phone: '720-111-2222',
                                  description: 'I love all of these pets.')
      app_1.pets << [pet_1, pet_2]
      ApplicationPet.approve_status(pet_1.id, app_1.id)
      result = Favorite.find_pending_adoption_pets
      expect(result).to eq([pet_2])
    end
  end
end
