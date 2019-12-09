require 'rails_helper'

RSpec.describe "Pet Application Index Page" do
  before(:each) do

        @shelter_1 = Shelter.create(name:    "Reptile Room",
                                    address: "2364 Desert Lane",
                                    city:    "Denver",
                                    state:   "CO",
                                    zip:     "80211")

        @pet_1 = Pet.create(image:      "https://www.lllreptile.com/uploads/images/StoreInventoryImage/14570/large",
                            name:       "Alfredo",
                            description:       "I'm a white ball python!",
                            approximate_age:        "4",
                            sex:        "female",
                            adoption_status:     "adoptable",
                            shelter_id: @shelter_1.id)

        @pet_2 = Pet.create(image:     "https://www.geek.com/wp-content/uploads/2019/04/pantherchameleon1-625x352.jpg",
                           name:       "Poppy",
                           description:       "I'm a panther chameleon! I am not very social but am fun to look at.",
                           approximate_age:        "2",
                           sex:        "male",
                           adoption_status:     "adoptable",
                           shelter_id: @shelter_1.id)

        @app_1 = Application.create(name: 'Harrison Levin',
                                    address: '1234 Lame Street',
                                    city: 'Denver',
                                    state: 'CO',
                                    zip: '80211',
                                    phone: '720-111-2222',
                                    description: 'I love all of these pets.')

        @app_2 = Application.create(name: 'Melissa Robbins',
                                    address: '3632 Mariposa Street',
                                    city: 'Denver',
                                    state: 'CO',
                                    zip: '80211',
                                    phone: '415-608-4157',
                                    description: 'I love all of these pets.')

        @app_1.pets << [@pet_1, @pet_2]
        @app_2.pets <<[@pet_1]

  end

  it "pet page has link to open applicaions for pet, link takes you to application show page" do

    visit "/pets/#{@pet_1.id}"

    click_link "View Applicants"

    expect(current_path).to eq("/pets/#{@pet_1.id}/applications")

    expect(page).to have_content("Applicants for #{@pet_1.name}")
    expect(page).to have_link("Melissa Robbins")

    click_link 'Harrison Levin'

    expect(current_path).to eq("/applications/#{@app_1.id}")
  end
end
