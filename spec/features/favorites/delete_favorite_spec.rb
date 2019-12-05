require 'rails_helper'

describe "favorite button changes when clicked and nav link updates", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Save Cats",
                              address: "123 Pine",
                              city: "Denver",
                              state: "Colorado",
                              zip: 80112)

    @pet_1 = @shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                        name: "Jersey",
                        approximate_age: 10,
                        sex: "Male")

    @pet_2 = @shelter_1.pets.create(image: 'https://images.pexels.com/photos/128756/pexels-photo-128756.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                        name: "Fish",
                        approximate_age: 5,
                        sex: "Female")
  end

    it "clicks favorite, nav increments, clicks unfavorite, nav decrements" do
      visit "/pets/#{@pet_1.id}"
      expect(page).to have_content("Favorites: 0")
      find_button("Favorite").click
      expect(page).to have_content("Favorites: 1")
      expect(page).to have_current_path("/pets/#{@pet_1.id}")
      expect(page).to have_no_button("Favorite")
      find_button("Unfavorite").click
      expect(page).to have_content("Favorites: 0")
      expect(page).to have_no_button("Unfavorite")
      find_button("Favorite").visible?
    end

    describe "remove pet favorite from favorite index page" do
      it "removes the pet from the index page and redirect to index page" do
        visit "/pets/#{@pet_1.id}"
        expect(page).to have_content("Favorites: 0")
        find_button("Favorite").click
        expect(page).to have_content("Favorites: 1")

        visit "/favorites"
        expect(page).to have_content("Favorites: 1")
        within "#favorites-#{@pet_1.id}" do
          find_button("Remove from Favorites").click
        end
        expect(page).to have_current_path("/favorites")
        expect(page).to have_content("Favorites: 0")
        expect(page).to_not have_css("#favorites-#{@pet_1.id}")
      end
    end

  end
