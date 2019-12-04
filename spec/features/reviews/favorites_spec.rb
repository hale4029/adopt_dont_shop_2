require 'rails_helper'

describe "favorites", type: :feature do
  it "nav bar counts the amount of favorited pets"  do
    visit "/"
    find_link("Favorites: 0").visible?
    visit "/shelters"
    find_link("Favorites: 0").visible?

    within "#shleter-#{@shelter_1.id}" do
      find_link("Favorite").click
    end

    expect(page).to have_current_path("/shelters")
    find_link("Favorites: 1").visible?

    within "#shleter-#{@shelter_2.id}" do
      find_link("Favorite").click
    end

    expect(page).to have_current_path("/shelters")
    find_link("Favorites: 2").visible?
  end

  
end
