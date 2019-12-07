require 'rails_helper'

RSpec.describe "adoption application" do
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
                        adoption_status:     "adoptable",
                        shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(image:     "https://www.geek.com/wp-content/uploads/2019/04/pantherchameleon1-625x352.jpg",
                       name:       "Poppy",
                       description:       "I'm a panther chameleon! I am not very social but am fun to look at.",
                       approximate_age:        "2",
                       sex:        "male",
                       adoption_status:     "adoptable",
                       shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(image:      "https://localtvwiti.files.wordpress.com/2016/06/thinkstockphotos-528306066.jpg?quality=85&strip=all&w=400&h=225&crop=1",
                        name:       "Betsy",
                        description:       "I'm a blue tang fish. You might recognize me from the movie 'Finding Nemo'! I require a salt water tank.",
                        approximate_age:        "1",
                        sex:        "female",
                        adoption_status:     "adoptable",
                        shelter_id: @shelter_2.id)
    end

  it "shows selection of pets that have been favorited" do

    visit "/pets/#{@pet_1.id}"
    click_button 'Favorite'

    visit "/pets/#{@pet_2.id}"
    click_button 'Favorite'

    visit "/pets/#{@pet_3.id}"
    click_button 'Favorite'

    visit "/favorites"
    click_button 'Create Application'

    expect(current_path).to eq("/applications")

    expect(page).to have_content("Adoption Application")

    within "##{@pet_1.id}-section" do
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_field("checkbox-#{@pet_1.id}", checked: false)
    end

    within "##{@pet_2.id}-section" do
      expect(page).to have_content("#{@pet_2.name}")
      expect(page).to have_field("checkbox-#{@pet_2.id}", checked: false)
    end

    within "##{@pet_3.id}-section" do
      expect(page).to have_content("#{@pet_3.name}")
      expect(page).to have_field("checkbox-#{@pet_3.id}", checked: false)
    end

    find_field(:name)
    find_field(:address)
    find_field(:city)
    find_field(:state)
    find_field(:zip)
    find_field(:phone)
    find_field(:description)

    expect(page).to have_button('Submit')
  end
end
