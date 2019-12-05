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

  it "has an edit button next to each review on the page" do

    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      expect(page).to have_button('Edit')
    end

    within "#review-#{@review_2.id}" do
      expect(page).to have_button('Edit')
    end
  end

  it "has an edit button for each review which when clicked goes to edit form view" do

    visit "/shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      click_button('Edit')
    end

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")
  end

  describe "review edit page" do

    it "pre-populates edit form to include previous information" do

      visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

      expect(page).to have_content('Title')
      expect(page).to have_content('Rating')
      expect(page).to have_content('Content')
      expect(page).to have_content('Image')

      expect(page).to have_button('Submit')

      expect(find_field('title').value).to eq(@review_1.title)
      expect(find_field('rating').value.to_i).to eq(@review_1.rating)
      expect(find_field('content').value).to eq(@review_1.content)
      expect(find_field('picture').value).to eq(@review_1.picture)
    end

    it "allows a user to fill in fields and submit" do

      visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

      fill_in 'title', with: 'Smelly and gross'
      fill_in 'content', with: 'We were not happy about it.'

      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      within "#review-#{@review_1.id}" do
        expect(page).to have_content('Smelly and gross')
        expect(page).to have_content('We were not happy about it.')
      end

      expect(page).to_not have_content('Smelly!')
      expect(page).to_not have_content('Dog poop everywhere!')
    end

    it "does not allow a user to edit a review without required information" do

      visit "/shelters/#{@shelter_1.id}/reviews/#{@review_2.id}/edit"

      fill_in 'title', with: ''

      click_button('Submit')

      expect(page).to_not have_content('Wonderful')
      expect(page).to have_content('Review not saved. Please complete required fields.')
      expect(page).to have_button('Submit')

      fill_in 'title', with: 'This place is great!'
      fill_in 'content', with: ''

      click_button('Submit')

      expect(page).to have_content('Review not saved. Please complete required fields.')
      expect(page).to have_button('Submit')

      fill_in 'title', with: 'Love this place!'
      select '5', from: :rating
      fill_in 'content', with: 'Always has a great selection of dogs, puppies and more!'

      click_button('Submit')

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content('Love this place!')
      expect(page).to have_content('Always has a great selection of dogs, puppies and more!')

      expect(page). to_not have_content('This place is great!')
      expect(page). to_not have_content('Appreciate the selection.')
    end
  end
end
