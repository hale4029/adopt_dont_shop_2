require 'rails_helper'

RSpec.describe "applications show page " do
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
                        shelter_id: @shelter_1.id)

    @pet_2 = Pet.create(image:     "https://www.geek.com/wp-content/uploads/2019/04/pantherchameleon1-625x352.jpg",
                       name:       "Poppy",
                       description:       "I'm a panther chameleon! I am not very social but am fun to look at.",
                       approximate_age:        "2",
                       sex:        "male",
                       shelter_id: @shelter_1.id)

    @app_1 = Application.create(name: 'Harrison Levin',
                                address: '1234 Lame Street',
                                city: 'Denver',
                                state: 'CO',
                                zip: '80211',
                                phone: '720-111-2222',
                                description: 'I love all of these pets.')

    @app_1.pets << [@pet_1, @pet_2]
  end

  it "shows all info from application" do

    visit "/applications/#{@app_1.id}"

    expect(page).to have_content("Name: #{@app_1.name}")
    expect(page).to have_content("Address: #{@app_1.address}")
    expect(page).to have_content("City: #{@app_1.city}")
    expect(page).to have_content("State: #{@app_1.state}")
    expect(page).to have_content("Zip: #{@app_1.zip}")
    expect(page).to have_content("Phone: #{@app_1.phone}")
    expect(page).to have_content("Description: #{@app_1.description}")

    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_2.name)

    click_link(@pet_1.name)

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it "shows link to approve application for each pet" do

    visit "/applications/#{@app_1.id}"

    within "#section-#{@pet_1.id}" do
      click_button 'Approve Application'
    end

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Adoption Status: Pending Adoption")
    expect(page).to_not have_content("Adoption Status: Adoptable")
    expect(page).to have_content("Pet on hold for #{@app_1.name}")


    # within "#open_apps_#{@pet_1.id}" do
    #   expect(page).to have_content(@pet_1.name)
    # end


  end
end
