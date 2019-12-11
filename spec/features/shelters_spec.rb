require 'rails_helper'

describe "shelters story tests", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Save Cats",
                              address: "123 Pine",
                              city: "Denver",
                              state: "Colorado",
                              zip: 80112)
    @shelter_2 = Shelter.create(name: "Save Dogs",
                              address: "134 Pine",
                              city: "Littleton",
                              state: "Colorado",
                              zip: 80111)
  end

  describe "shelters index page" do
    it "show all shelters" do

      visit '/shelters/'

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
    end
  end


  describe "shelter id page" do
    it "show shelter (id) page and details" do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to have_content(@shelter_1.zip)

      visit "/shelters/#{@shelter_2.id}"

      expect(page).to have_content(@shelter_2.address)
      expect(page).to have_content(@shelter_2.address)
      expect(page).to have_content(@shelter_2.city)
      expect(page).to have_content(@shelter_2.zip)
    end
  end

  describe "shelter create page" do
    it "contains button and inputs" do

      visit "/shelters/new"

      expect(page).to_not have_content('New Sheleter Name')
      expect(page).to have_button("Create Shelter")
      fill_in(:name, :with => 'New Shelter Name')
      fill_in(:address, :with => '123 Pine')
      fill_in(:city, :with => 'Denver')
      fill_in(:state, :with => 'Colorado')
      fill_in(:zip, :with => 80122 )
    end

    it "creates new shelter" do

      visit "/shelters/new"
      expect(page).to have_current_path("/shelters/new")

      fill_in(:name, :with => 'New Shelter Name')
      fill_in(:address, :with => '123 Pine')
      fill_in(:city, :with => 'Denver')
      fill_in(:state, :with => 'Colorado')
      fill_in(:zip, :with => 80122 )
      find_button('Create Shelter').click

      expect(page).to have_current_path("/shelters")
      find_link('New Shelter Name').click

      expect(page).to have_content('New Shelter Name')
      expect(page).to have_content('123 Pine')
      expect(page).to have_content('Denver')
      expect(page).to have_content('Colorado')
      expect(page).to have_content(80122)

    end
  end

  describe "shelter id page allowing edit functionality" do
    it "has edit button and redirect to form page with filled form field" do

      visit "/shelters/#{@shelter_1.id}"

      find_link('Edit').visible?
      find_link('Edit').click

      expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")
      expect(page).to have_button("Update Shelter")
      find_field(:name)
      find_field(:address)
      find_field(:city)
      find_field(:state)
      find_field(:zip)
      fill_in(:name, :with => 'Updated Shelter Name')
      fill_in(:address, :with => '123 Pine')
      fill_in(:city, :with => 'Denver')
      fill_in(:state, :with => 'Colorado')
      fill_in(:zip, :with => 80123 )
      find_button('Update Shelter').click

      expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
      expect(page).to have_content('Updated Shelter Name')
      expect(page).to have_content('123 Pine')
      expect(page).to have_content('Denver')
      expect(page).to have_content('Colorado')
      expect(page).to have_content(80123)


    end
  end

  describe "delete a shelter" do
    it "check if delete button exists and it removes shelter from shelter index" do

      visit "/shelters"

      expect(page).to have_content(@shelter_2.name)

      visit "/shelters/#{@shelter_2.id}"

      find_link('Delete')
      find_link('Delete').click

      expect(page).to have_current_path("/shelters")
      expect(page).to_not have_content(@shelter_2.name)
    end
  end

  describe "test story 13" do
    it "test edit link for every shelter on shelter index page" do
      visit "/shelters"
      page.assert_selector(:link, 'Edit', count: 2)
    end
  end

  describe "test story 14" do
    it "test delete link for every shelter on shelter index page" do
      visit "/shelters"
      page.assert_selector(:link, 'Delete', count: 2)
    end
  end

  describe "user story 29" do
    it "will alert the user with individual fields missing when creating a shelter" do

      visit "/shelters/new"

      fill_in 'name', with: ''
      fill_in 'address', with: '27 Skylark Drive'
      fill_in 'city', with: 'Denver'
      fill_in 'state', with: 'CO'
      fill_in 'zip', with: 80215

      click_button 'Create Shelter'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_button('Create Shelter')

      fill_in 'name', with: ''
      fill_in 'address', with: '27 Skylark Drive'
      fill_in 'city', with: ''
      fill_in 'state', with: 'CO'
      fill_in 'zip', with: 80215

      click_button 'Create Shelter'

      expect(page).to have_content("Name can't be blank and City can't be blank")
      expect(page).to have_button('Create Shelter')

      fill_in 'name', with: 'The Aviary'
      fill_in 'address', with: '27 Skylark Drive'
      fill_in 'city', with: 'Denver'
      fill_in 'state', with: 'CO'
      fill_in 'zip', with: '80215'

      click_button 'Create Shelter'

      expect(current_path).to eq("/shelters")
      expect(page).to have_content("Shelter created!")
    end

    it "will alert the user with individual fields missing when updating a shelter" do

      visit "/shelters/#{@shelter_1.id}/edit"

      fill_in 'name', with: ''
      fill_in 'address', with: '27 Skylark Drive'
      fill_in 'city', with: 'Denver'
      fill_in 'state', with: 'CO'
      fill_in 'zip', with: 80215

      click_button 'Update Shelter'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_button('Update Shelter')

      fill_in 'name', with: ''
      fill_in 'address', with: '27 Skylark Drive'
      fill_in 'city', with: ''
      fill_in 'state', with: 'CO'
      fill_in 'zip', with: 80215

      click_button 'Update Shelter'

      expect(page).to have_content("Name can't be blank and City can't be blank")
      expect(page).to have_button('Update Shelter')

      fill_in(:name, :with => 'Updated Shelter Name')
      fill_in(:address, :with => '123 Pine')
      fill_in(:city, :with => 'Denver')
      fill_in(:state, :with => 'Colorado')
      fill_in(:zip, :with => 80123 )

      click_button 'Update Shelter'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content("Shelter updated!")
    end
  end
end
