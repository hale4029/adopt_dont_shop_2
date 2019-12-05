require 'rails_helper'

describe "favorites", type: :feature do
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

    @review_1 = @shelter_1.reviews.create(title: "Smelly!",
                                          rating: 1,
                                          content: "Dog poop everywhere!",
                                          picture: "https://cdn11.bigcommerce.com/s-vmvni2zq0j/images/stencil/1280x1280/products/41507/52612/610106__25520.1500584693.jpg?c=2&imbypass=on&imbypass=on")

    @review_2 = @shelter_1.reviews.create(title: "Wonderful",
                                          rating: 5,
                                          content: "Beautiful!")
  end

  it "nav bar counts the amount of favorited pets"  do

    visit "/"
    #find_link("Favorites: 0").visible?
    visit "/shelters"
    #find_link("Favorites: 0").visible?
    expect(page).to have_content("Favorites: 0")

    visit "/pets/#{@pet_1.id}"
    #find_link("Favorites: 0").visible?
    find_button("Favorite").click
    #find_link("Favorites: 1").visible?
    expect(page).to have_content("Favorites: 1")
    expect(page).to have_content("#{@pet_1.name} added to your favorites!")

    visit "/pets/#{@pet_2.id}"
    find_button("Favorite").click
    expect(page).to have_content("Favorites: 2")
    #find_link("Favorites: 2").visible?
    expect(page).to have_content("#{@pet_2.name} added to your favorites!")
    expect(page).to have_current_path("/pets/#{@pet_2.id}")

  end


end
