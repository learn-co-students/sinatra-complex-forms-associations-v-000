require 'spec_helper'

describe "Pets Controller" do
<<<<<<< HEAD
  describe "new action" do
=======
  describe "new action" do 
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9

    it "can visit '/pets/new'" do
      get '/pets/new'
      expect(last_response.status).to eq(200)
    end

    it " loads form to create a new pet" do
      visit '/pets/new'
<<<<<<< HEAD
      expect(page).to have_field('pet_name')
=======
      expect(page).to have_field(:pet_name)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
    end

    it "has a form with a checkbox for existing owners" do
      @owner1 = Owner.create(:name => "Cricky")
      @owner2 = Owner.create(:name => "Chris")

      visit '/pets/new'
<<<<<<< HEAD
      expect(page.has_unchecked_field?(@owner1.id)).to eq(true)
      expect(page.has_unchecked_field?(@owner2.id)).to eq(true)
=======
      expect(page.has_unchecked_field?(@owner1.name)).to eq(true)
      expect(page.has_unchecked_field?(@owner2.name)).to eq(true)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
    end

    it "has a field for creating a new owner" do
      visit '/pets/new'
      expect(page).to have_field(:owner_name)
    end


    it "creates a new pet and associates an existing owner" do
      @owner1 = Owner.create(:name => "Cricky")
      @owner2 = Owner.create(:name => "Chris")
      visit '/pets/new'
      fill_in "pet_name", :with => "Michael"
<<<<<<< HEAD
      check(@owner1.id)
=======
      check(@owner1.name)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      click_button "Create Pet"
      @pet = Pet.last
      expect(@pet.name).to eq("Michael")
      expect(@pet.owner.name).to eq("Cricky")
    end

      it " creates a new pet and a new owner" do
      visit '/pets/new'
      fill_in "pet_name", :with => "Pippa"
      fill_in "owner_name", :with => "Mary Nelson"
      click_button "Create Pet"
      @owner = Owner.last
      @pet = Pet.last
      expect(@pet.name).to eq("Pippa")
      expect(@pet.owner.name).to eq("Mary Nelson")
    end

    it "redirects to '/pets/:id' after form submissions" do
      @owner1 = Owner.create(:name => "Kristi")
      @owner2 = Owner.create(:name => "Kaitlin")
      visit '/pets/new'
      fill_in "pet_name", :with => "Joeseph"
<<<<<<< HEAD
      check(@owner2.id)
=======
      check(@owner2.name)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      click_button "Create Pet"
      @pet= Pet.last
      expect(page.current_path).to eq("/pets/#{@pet.id}")
    end
  end

<<<<<<< HEAD
  describe "edit action" do
=======
  describe "edit action" do 
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
    before(:each) do
      @owner = Owner.create(:name => "Carla")
      @pet = Pet.create(:name => "Chewie", :owner_id => @owner.id)
    end

<<<<<<< HEAD
    it "can visit '/owners/:id/edit' " do
      get "/owners/#{@owner.id}/edit"
=======
    it "can visit '/pets/:id/edit' " do 
      get "/owners/#{@pet.id}/edit"
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      expect(last_response.status).to eq(200)
    end

    it " loads form to edit a pet and his owner" do
      visit "/pets/#{@pet.id}/edit"
<<<<<<< HEAD
      expect(page).to have_field('pet_name')
      expect(page.has_checked_field?(@owner.id)).to eq(true)
      expect(page).to have_field('owner[name]')
=======
      expect(page).to have_field(:pet_name)
      expect(page.has_checked_field?(@owner.name)).to eq(true)
      expect(page).to have_field(:owner_name)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
    end

     it "edit's the pet's name" do
      visit "/pets/#{@pet.id}/edit"
      fill_in "pet_name", :with => "Chewie Darling"
      click_button "Update Pet"
      expect(Pet.last.name).to eq("Chewie Darling")
    end

    it "edit's the pet's owner with an existing owner" do
      @adam = Owner.create(:name => "Adam")
      visit "/pets/#{@pet.id}/edit"
<<<<<<< HEAD
      choose(@adam.id)
=======
      check("Adam")
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      click_button "Update Pet"
      expect(Pet.last.owner.name).to eq("Adam")
    end

    it "edit's the pet's owner with a new owner" do
      visit "/pets/#{@pet.id}/edit"
      fill_in "owner_name", :with => "Samantha"
      click_button "Update Pet"
      expect(Pet.last.owner.name).to eq("Samantha")
    end


  end

<<<<<<< HEAD
end
=======
end
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
