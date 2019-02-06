require 'spec_helper'

describe "Owners Controller" do
  describe "new action" do 

    it "can visit '/owners/new'" do
      get '/owners/new'
      expect(last_response.status).to eq(200)
    end

    it "'/owners/new' loads form to create a new owner" do
      visit '/owners/new'
      expect(page).to have_field('owner[name]')
    end



    it "'/owners/new' form has a field for creating a new pet" do
      visit '/owners/new'
      expect(page).to have_field('pet[name]')
    end

      it "'/owners/new' creates a new owner and a new pet" do
      @pet1 = Pet.create(:name => "Bessie") 
      @pet2 = Pet.create(:name => "Sadie")
      visit '/owners/new'
      fill_in "owner[name]", :with => "Sophie"
      fill_in "pet[name]", :with => "Caldwell"
      click_button "Create Owner"
      @owner = Owner.last
      @pet = Pet.last
      expect(@owner.name).to eq("Sophie")
      expect(@owner.pets.first.name).to eq("Caldwell")
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


  end

end