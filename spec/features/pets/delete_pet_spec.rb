require 'rails_helper'

RSpec.describe "removes favorite after deleting pet" do
  before(:each) do

    @shelter_1 = Shelter.create(name:    "Reptile Room",
                                address: "2364 Desert Lane",
                                city:    "Denver",
                                state:   "CO",
                                zip:     "80211")

    @shelter_2 = Shelter.create(name: "Save Dogs",
                                address: "134 Pine",
                                city: "Littleton",
                                state: "Colorado",
                                zip: "80111")

    @pet_1 = Pet.create(image:      "https://www.lllreptile.com/uploads/images/StoreInventoryImage/14570/large",
                        name:       "Alfredo",
                        description:       "I'm a white ball python!",
                        approximate_age:        "4",
                        sex:        "female",
                        shelter_id: @shelter_1.id)

    @app_1 = Application.create(name: 'Harrison Levin',
                                address: '1234 Lame Street',
                                city: 'Denver',
                                state: 'CO',
                                zip: '80211',
                                phone: '720-111-2222',
                                description: 'I love all of these pets.')
  end

  it "removes favorite" do
    visit "/pets/#{@pet_1.id}"
    find_button("Favorite").click
    expect(page).to have_content("Favorites: 1")
    visit "/pets/#{@pet_1.id}"
    click_link("Delete")
    expect(page).to have_content("Favorites: 0")
  end
end
