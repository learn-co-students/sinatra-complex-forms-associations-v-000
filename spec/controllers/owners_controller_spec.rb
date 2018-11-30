require 'spec_helper'

describe "Owners Controller" do
  describe "new action" do 

    it "can visit '/owners/new'" do
      get '/owners/new'
      expect(last_response.status).to eq(200)
    end

    it "'/owners/new' loads form to create a new owner" do
      visit '/owners/new'
<<<<<<< HEAD
      expect(page).to have_field('owner[name]')
=======
      expect(page).to have_field(:owner_name)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
    end

    it "'/owners/new' form has a checkbox for existing pets" do
      @pet1 = Pet.create(:name => "Bessie")
      @pet2 = Pet.create(:name => "Sadie")
      visit '/owners/new'
<<<<<<< HEAD
      expect(page.has_unchecked_field?(@pet1.id)).to eq(true)
      expect(page.has_unchecked_field?(@pet2.id)).to eq(true)
=======
      expect(page.has_unchecked_field?(@pet1.name)).to eq(true)
      expect(page.has_unchecked_field?(@pet2.name)).to eq(true)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
    end

    it "'/owners/new' form has a field for creating a new pet" do
      visit '/owners/new'
<<<<<<< HEAD
      expect(page).to have_field('pet[name]')
=======
      expect(page).to have_field(:pet_name)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
    end


    it "'/owners/new' creates a new owner and associates an existing pet " do
      @pet1 = Pet.create(:name => "Bessie") 
      @pet2 = Pet.create(:name => "Sadie")
      visit '/owners/new'
<<<<<<< HEAD
      fill_in "owner[name]", :with => "Sophie"
      check(@pet1.id)
=======
      fill_in "owner_name", :with => "Sophie"
      check(@pet1.name)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      click_button "Create Owner"
      @owner = Owner.last
      expect(@owner.name).to eq("Sophie")
      expect(@owner.pets.first.name).to eq("Bessie")
    end

      it "'/owners/new' creates a new owner and a new pet" do
      @pet1 = Pet.create(:name => "Bessie") 
      @pet2 = Pet.create(:name => "Sadie")
      visit '/owners/new'
<<<<<<< HEAD
      fill_in "owner[name]", :with => "Sophie"
      fill_in "pet[name]", :with => "Caldwell"
=======
      fill_in "owner_name", :with => "Sophie"
      fill_in "pet_name", :with => "Caldwell"
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      click_button "Create Owner"
      @owner = Owner.last
      @pet = Pet.last
      expect(@owner.name).to eq("Sophie")
      expect(@owner.pets.first.name).to eq("Caldwell")
    end

    it "'/owners/new' redirects to '/owners/:id' after form submissions" do
      @pet1 = Pet.create(:name => "Bessie") 
      @pet2 = Pet.create(:name => "Sadie")
      visit '/owners/new'
<<<<<<< HEAD
      fill_in "owner[name]", :with => "Sophie"
      check(@pet1.id)
=======
      fill_in "owner_name", :with => "Sophie"
      check(@pet1.name)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      click_button "Create Owner"
      @owner = Owner.last
      expect(page.current_path).to eq("/owners/#{@owner.id}")
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

    it "'/owners/:id/edit' loads form to edit an owner and his pets" do
      visit "/owners/#{@owner.id}/edit"
<<<<<<< HEAD
      expect(page).to have_field('owner[name]')
      expect(page.has_checked_field?(@pet.id)).to eq(true)
      expect(page).to have_field('pet[name]')
=======
      expect(page).to have_field(:owner_name)
      expect(page.has_checked_field?(@pet.name)).to eq(true)
      expect(page).to have_field(:pet_name)
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
    end

     it "edit's the owner's name" do
      visit "/owners/#{@owner.id}/edit"
<<<<<<< HEAD
      fill_in "owner[name]", :with => "Carla Gremillion"
=======
      fill_in "owner_name", :with => "Carla Gremillion"
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      click_button "Update Owner"
      expect(Owner.last.name).to eq("Carla Gremillion")
    end

    it "edit's the owner's pets with an existing pet" do
      @shaggy = Pet.create(:name => "Shaggy")
      visit "/owners/#{@owner.id}/edit"
<<<<<<< HEAD
      check(@shaggy.id)
=======
      check("Shaggy")
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      click_button "Update Owner"
      expect(Owner.last.pets.last.name).to eq("Shaggy")
    end

    it "edit's the owner's pets with a new pet" do
      visit "/owners/#{@owner.id}/edit"
<<<<<<< HEAD
      fill_in "pet[name]", :with => "Carlton"
=======
      fill_in "pet_name", :with => "Carlton"
>>>>>>> 2dc5010ed581ce2b454fb9eab0955003f1ef6dd9
      click_button "Update Owner"
      expect(Owner.last.pets.last.name).to eq("Carlton")
    end


  end

end