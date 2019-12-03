require 'rails_helper'

describe "shelters show page", type: :feature do
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

  it "has a link to add a review" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link 'Add Review'
  end

  it "has a link which when clicked goes to create review form" do

    visit "/shelters/#{@shelter_1.id}"

    click_link 'Add Review'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews_new")

    expect(page).to have_content('Add Review')

    find_field(:title)
    find_field(:rating)
    find_field(:content)
    find_field(:picture)

    expect(page).to have_button('Submit')
  end

  it "allows a user to create a review" do

    visit "/shelters/#{@shelter_1.id}/reviews_new"

    fill_in 'title', with: 'Love this place!'
    select '5', from: :rating
    fill_in 'content', with: 'Always has a great selection of dogs, puppies and more!'

    click_button('Submit')

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    expect(page).to have_content('Love this place!')
    expect(page).to have_content('5')
    expect(page).to have_content('Always has a great selection of dogs, puppies and more!')
  end
end
