class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    #creates a new pet with the input from the user, if they created a new owner it makes that the pet's owner
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    #Finds the pet with the specific id the user adds to thr route
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    #Posts the users input into the route.
    #makes class variable with the pet that has the id in the route, updates the pet with the user's changes
    #if the user creates a new owner, it adds that pet to the owner, and saves all the updates
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
end
