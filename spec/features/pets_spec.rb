require 'rails_helper'

describe "pets story tests", type: :feature do
  before :each do

    @shelter_1 = Shelter.create(name: "Save Cats",
                              address: "123 Pine",
                              city: "Denver",
                              state: "Colorado",
                              zip: 80112)

    @pet_1 = @shelter_1.pets.create(image: 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080',
                        name: "Jersey",
                        approximate_age: 10,
                        sex: "Male")

    @shelter_2 = Shelter.create(name: "Save Dogs",
                              address: "134 Pine",
                              city: "Littleton",
                              state: "Colorado",
                              zip: 80111)

    @pet_2 = @shelter_2.pets.create(image: 'https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg',
                        name: "Hershey",
                        approximate_age: 5,
                        sex: "Male")
  end

  describe "pets index page" do
    it "show all pets across shelters" do

      visit '/pets'

      expect(page).to have_css("img[src*='https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080']")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.approximate_age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_content(@pet_1.shelter.name)

      expect(page).to have_css("img[src*='https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg']")
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.approximate_age)
      expect(page).to have_content(@pet_2.sex)
      expect(page).to have_content(@pet_2.shelter.name)
    end

  end

  describe "pets page linked to a shelter" do
    it "should show all the pets at the shelter with the pet info" do

      visit "/shelters/#{@shelter_1.id}"
      find_link('View Pets').click
      expect(page).to have_current_path("/shelters/#{@shelter_1.id}/pets")

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.approximate_age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to_not have_content(@pet_2.name)

      visit "/shelters/#{@shelter_2.id}"
      find_link('View Pets').click
      expect(page).to have_current_path("/shelters/#{@shelter_2.id}/pets")

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.approximate_age)
      expect(page).to have_content(@pet_2.sex)
      expect(page).to_not have_content(@pet_1.name)

      find_link('Back to Shelter').visible?

    end
  end

  describe "pet's detail via pets index page" do
    it "should show additional detail regarding description and adoptability" do

      visit "/pets/#{@pet_1.id}"

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_css("img[src*='https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/09/dog-landing-hero-lg.jpg?bust=1536935129&width=1080']")
      expect(page).to have_content(@pet_1.approximate_age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_content(@pet_1.shelter.name)
      expect(page).to have_content(@pet_1.description)
      expect(page).to have_content(@pet_1.adoption_status)
      expect(page).to_not have_content(@pet_2.name)

    end
  end

  describe "create new pet nested under shelter" do
    it "creates new pet and data is displayed on shelet's pet page" do
      visit "/shelters/#{@shelter_1.id}/pets"
      find_link("Add New Pet").click
      expect(page).to have_current_path("/shelters/#{@shelter_1.id}/pets/new")

      fill_in(:image, :with => 'https://www.thesprucepets.com/thmb/lf_bKsXU1WWVec7FkQTFI2FxBvc=/960x0/filters:no_upscale():max_bytes(150000):strip_icc()/golden-retriever-sitting-down-in-a-farm-837898820-5c7854ff46e0fb00011bf29a.jpg')
      fill_in(:name, :with => 'Berkley')
      fill_in(:description, :with => 'Fluffy golden')
      fill_in(:approximate_age, :with => 2)
      select('Male', :from => :sex)
      find_button('Create Pet').click

      expect(page).to have_current_path("/shelters/#{@shelter_1.id}/pets")
      expect(page).to have_content('Berkley')
      expect(page).to have_css("img[src*='https://www.thesprucepets.com/thmb/lf_bKsXU1WWVec7FkQTFI2FxBvc=/960x0/filters:no_upscale():max_bytes(150000):strip_icc()/golden-retriever-sitting-down-in-a-farm-837898820-5c7854ff46e0fb00011bf29a.jpg']")
      expect(page).to have_content(2)
      expect(page).to have_content('Male')
    end
  end


  describe "update pet information" do
    it "updates pet info via pet's show page" do
      visit "/pets/#{@pet_1.id}"
      find_link("Edit").click
      expect(page).to have_current_path("/pets/#{@pet_1.id}/edit")

      fill_in(:image, :with => 'https://www.thesprucepets.com/thmb/lf_bKsXU1WWVec7FkQTFI2FxBvc=/960x0/filters:no_upscale():max_bytes(150000):strip_icc()/golden-retriever-sitting-down-in-a-farm-837898820-5c7854ff46e0fb00011bf29a.jpg')
      fill_in(:name, :with => 'Berkley')
      fill_in(:description, :with => 'Fluffy golden big time')
      fill_in(:approximate_age, :with => 3)
      select('Female', :from => :sex)
      find_button('Update Pet Info').click
      expect(page).to have_current_path("/pets/#{@pet_1.id}")

      expect(page).to have_content('Fluffy golden big time')
      expect(page).to have_content(3)
      expect(page).to have_content('Female')
    end
  end

  describe "delete pet information" do
    it "deletes pet info from pet show page" do
      visit "/pets/#{@pet_1.id}"
      find_link("Delete").click

      expect(page).to_not have_content('Berkley')

    end
  end

  describe "test story 15" do
    it "test edit link for every shelter on shelter index page" do
      visit "/pets"
      page.assert_selector(:link, 'Edit', count: 2)
    end
  end

  describe "test story 16" do
    it "test delete link for every shelter on shelter index page" do
      visit "/pets"
      page.assert_selector(:link, 'Delete', count: 2)
    end
  end

  describe "test adoption status change" do
    it "changes status to adoption-pending" do
      visit "/pets/#{@pet_1.id}"
      expect(page).to have_content("Adoption Status: adoptable")
      find_link("Submit Adoption Request").click
      expect(page).to have_content("Adoption Status: adoption-pending")
      find_link("Cancel Adoption Request").click
      expect(page).to have_content("Adoption Status: adoptable")
    end
  end

  describe "test adoption status and sort function on pets index page" do
    it "change in status results:" do
      visit "/pets/"
      find_link("Hershey").visible?
      find_link("Jersey").visible?
      find_link("Jersey").click
      find_link("Submit Adoption Request").click
      find_link("Back to Pets").click
      find_link("Hershey").visible?
      find_link("Jersey").visible?
      find_link("Only Show Adoptable Pets").click
      find_link("Hershey").visible?
      expect(page).to_not have_content('Jersey')
      find_link("Only Show Adoption-Pending Pets").click
      expect(page).to_not have_content('Hershey')
      find_link("Jersey").visible?
    end
  end






end
