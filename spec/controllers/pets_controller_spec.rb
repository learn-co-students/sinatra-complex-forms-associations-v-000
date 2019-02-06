require 'spec_helper'

describe "Pets Controller" do
  describe "new action" do

    it "can visit '/pets/new'" do
      get '/pets/new'
      expect(last_response.status).to eq(200)
    end

    it " loads form to create a new pet" do
      visit '/pets/new'
      expect(page).to have_field('pet_name')
    end

   

    it "has a field for creating a new owner" do
      visit '/pets/new'
      expect(page).to have_field(:owner_name)
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

  end

  describe "edit action" do
    before(:each) do
      @owner = Owner.create(:name => "Carla")
      @pet = Pet.create(:name => "Chewie", :owner_id => @owner.id)
    end

    it "can visit '/owners/:id/edit' " do
      get "/owners/#{@owner.id}/edit"
      expect(last_response.status).to eq(200)
    end

  
     it "edit's the pet's name" do
      visit "/pets/#{@pet.id}/edit"
      fill_in "pet_name", :with => "Chewie Darling"
      click_button "Update Pet"
      expect(Pet.last.name).to eq("Chewie Darling")
    end


    it "edit's the pet's owner with a new owner" do
      visit "/pets/#{@pet.id}/edit"
      fill_in "owner_name", :with => "Samantha"
      click_button "Update Pet"
      expect(Pet.last.owner.name).to eq("Samantha")
    end


  end

end
