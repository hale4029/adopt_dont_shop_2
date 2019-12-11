require 'rails_helper'

RSpec.describe "cannot delete a shelter with an approved pet" do
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
    @app_1.pets << [@pet_1]
  end

  it "approve application for pet" do

    visit "/applications/#{@app_1.id}"

    within "#section-#{@pet_1.id}" do
      click_button 'Approve Application'
    end

    visit "/shelters"

    within "#section_shelter_#{@shelter_1.id}" do
      expect(page).to_not have_link("Delete")
    end

    within "#section_shelter_#{@shelter_2.id}" do
      expect(page).to have_link("Delete")
    end
  end
end
