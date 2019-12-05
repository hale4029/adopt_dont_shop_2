require 'rails_helper'

describe "shelters show page", type: :feature do
  before :each do

    @shelter_1 = Shelter.create(name: "Save Cats",
                              address: "123 Pine",
                              city: "Denver",
                              state: "Colorado",
                              zip: 80112)

    @review_1 = @shelter_1.reviews.create(title: "Smelly!",
                                          rating: 1,
                                          content: "Dog poop everywhere!",
                                          picture: "https://cdn11.bigcommerce.com/s-vmvni2zq0j/images/stencil/1280x1280/products/41507/52612/610106__25520.1500584693.jpg?c=2&imbypass=on&imbypass=on")

    @review_2 = @shelter_1.reviews.create(title: "Wonderful",
                                          rating: 5,
                                          content: "Beautiful!")
  end

  it "has a delete button next to each review on the page" do
    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      expect(page).to have_button('Delete')
    end

    within "#review-#{@review_2.id}" do
      expect(page).to have_button('Delete')
    end
  end

  it "has a delete button which when clicked deletes the review" do
    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      click_button('Delete')
    end

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    expect(page).to_not have_content("Smelly!")
    expect(page).to_not have_content("Dog poop everywhere!")
  end
end
