require 'rails_helper'

describe "favorites", type: :feature do
  it "nav bar counts the amount of favorited pets"  do
    visit "/"
    find_link("Favorites: 0").visible?
    visit "/shelters"
    find_link("Favorites: 0").visible?
    visit "/shelters/#{@shelter_1.id}/pets"
    find_link("Favorites: 0").visible?

    find_link("Favorite").click

    expect(page).to have_current_path("/shelters")
    find_link("Favorites: 1").visible?

  end


end
