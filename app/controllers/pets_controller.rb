require 'pry'

class PetsController < ApplicationController

  # Index pets
  # Set up instance var to list all pets
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  # New pet
  # Set up instance var to list all owners to be pass to select from existing owners
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  # POST to pets (index)
  post '/pets' do
    if params[:owner][:name].empty?
      # If owner field is empty create the pet with no owner
      @pet = Pet.create(params[:pet])
    else
      # Else create the pet, assign new pet to new owner, save to db
      @pet = Pet.create(params[:pet])
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    end
    # Redirect to new pet page
    redirect "pets/#{@pet.id}"
  end

  # Edit page
  get '/pets/:id/edit' do
    # Find the pet
    @pet = Pet.find(params[:id])
    # Pass instance var to find pet to assign to new owner
    @owners = Owner.all
    erb :'/pets/edit'
  end

  # Show page, find by its id
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  # Send to id page
  post '/pets/:id' do
    # Find the pet by id
    @pet = Pet.find(params[:id])
    # If owner.name === false...
    if params[:owner][:name].empty?
      # Update the pet without owner
      @pet.update(params[:pet])
    else
      # Else assign pet to new owner, save to db
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    end
    redirect "pets/#{@pet.id}"
  end
end
