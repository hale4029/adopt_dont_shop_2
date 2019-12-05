require 'rails_helper'

describe "favorites index page", type: :feature do
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

  it "favorite a pet that displays in the favorites' index page" do
    visit "/pets/#{@pet_1.id}"
    find_button("Favorite").click
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
    click_link("Favorites: 1")
    expect(page).to have_current_path("/favorites")

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.title)
        expect(page).to_not have_css("img[src*='#{@pet_1.image}']")
      end
  end



end
