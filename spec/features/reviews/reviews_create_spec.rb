require 'rails_helper'

describe "shelters show page", type: :feature do
  before :each do

    @shelter_1 = Shelter.create(name: "Save Cats",
                              address: "123 Pine",
                              city: "Denver",
                              state: "Colorado",
                              zip: 80112)
  end

  it "has a link to add a review" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link 'Add Review'
  end

  it "has a link which when clicked goes to create review form" do

    visit "/shelters/#{@shelter_1.id}"

    click_link 'Add Review'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

    expect(page).to have_content('Add Review')

    find_field(:title)
    find_field(:rating)
    find_field(:content)
    find_field(:picture)

    expect(page).to have_button('Submit')
  end

  it "allows a user to create a review" do

    visit "/shelters/#{@shelter_1.id}/reviews/new"

    fill_in 'title', with: 'Love this place!'
    select '5', from: :rating
    fill_in 'content', with: 'Always has a great selection of dogs, puppies and more!'

    click_button('Submit')

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    expect(page).to have_content('Love this place!')
    # expect(page).to have_content('5')
    expect(page).to have_content('Always has a great selection of dogs, puppies and more!')
  end

  it "does not allow a user to create a review without required information" do

    visit "/shelters/#{@shelter_1.id}/reviews/new"

    click_button('Submit')

    expect(page).to have_content('Review not created. Please complete required fields.')
    expect(page).to have_button('Submit')

    fill_in 'title', with: 'This place is great!'
    fill_in 'content', with: 'Appreciate the selection.'

    click_button('Submit')

    expect(page).to have_content('Review not created. Please complete required fields.')
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
