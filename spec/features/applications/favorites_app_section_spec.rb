require 'rails_helper'

RSpec.describe "favorite's application section" do
  before(:each) do
    @shelter_1 = Shelter.create(name:    "Reptile Room",
                                address: "2364 Desert Lane",
                                city:    "Denver",
                                state:   "CO",
                                zip:     "80211")
    @shelter_2 = Shelter.create(name:    "Fish Farm",
                                address: "8473 Ocean Drive",
                                city:    "Denver",
                                state:   "CO",
                                zip:     "80232")

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
    @pet_3 = Pet.create(image:      "https://localtvwiti.files.wordpress.com/2016/06/thinkstockphotos-528306066.jpg?quality=85&strip=all&w=400&h=225&crop=1",
                        name:       "Betsy",
                        description:       "I'm a blue tang fish. You might recognize me from the movie 'Finding Nemo'! I require a salt water tank.",
                        approximate_age:        "1",
                        sex:        "female",
                        shelter_id: @shelter_2.id)
  end

  it "favorites page has a section showing all the pets that have at least one application open" do
    visit "/pets/#{@pet_1.id}"
    click_button 'Favorite'

    visit "/pets/#{@pet_2.id}"
    click_button 'Favorite'

    visit "/pets/#{@pet_3.id}"
    click_button 'Favorite'

    visit "/favorites"
    click_link 'Create Application'

    find(:css, "#checkbox-#{@pet_1.id}").set(true)
    find(:css, "#checkbox-#{@pet_2.id}").set(true)

    fill_in 'name', with: 'Harrison Levin'
    fill_in 'address', with: '1234 Lame Street'
    fill_in 'city', with: 'Denver'
    fill_in 'state', with: 'CO'
    fill_in 'zip', with: '80211'
    fill_in 'phone', with: '720-111-2222'
    fill_in 'description', with: 'I love all of these pets.'

    click_button 'Submit'

    expect(current_path).to eq('/favorites')


    within "#container_fav" do
      expect(page).to_not have_content(@pet_1.name)
    end

    within "#container_fav" do
      expect(page).to_not have_content(@pet_2.name)
    end
    expect(page).to_not have_css("#open_apps_#{@pet_1.id}")
    expect(page).to_not have_css("#open_apps_#{@pet_2.id}")

  end
end
