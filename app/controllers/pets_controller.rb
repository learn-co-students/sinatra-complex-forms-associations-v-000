class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    #@pets = Pet.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    #binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    #binding.pry
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = Owner.all
    # binding.pry
    erb :'/pets/edit'
  end

  # it " loads form to edit a pet and his owner" do
  #   visit "/pets/#{@pet.id}/edit"
  #   expect(page).to have_field('pet_name')
  #   expect(page.has_checked_field?(@owner.id)).to eq(true)
  #   expect(page).to have_field('owner[name]')
  # end

  post '/pets/:id' do
    #binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    #binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
