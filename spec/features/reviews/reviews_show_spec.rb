require 'rails_helper'

describe "reviews for a shelter", type: :feature do
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

    @review_1 = @shelter_1.reviews.create(title: "Smelly!",
                                          rating: 1,
                                          content: "Dog poop everywhere!",
                                          picture: "https://cdn11.bigcommerce.com/s-vmvni2zq0j/images/stencil/1280x1280/products/41507/52612/610106__25520.1500584693.jpg?c=2&imbypass=on&imbypass=on")

    @review_2 = @shelter_1.reviews.create(title: "Wonderful",
                                          rating: 5,
                                          content: "Beautiful!")
  end


  it "shows multiple reviews for the shelter on the shelter's home page" do
    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.content)
      expect(page).to have_css("img[src*='#{@review_1.picture}']")
    end

    within "#review-#{@review_2.id}" do
      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_2.content)
      expect(page).to have_css("img[src*='#{@review_2.picture}']")
    end
  end

end
