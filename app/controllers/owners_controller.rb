require 'pry'

class OwnersController < ApplicationController

  get '/owners' do #view all owners
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do #render create new owner page
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    @owner = Owner.create(params[:owner]) #creates a new owner
    pet =
    pets = Pet.all
    pets.detect do |pet|
      binding.pry
      if pet.name == ""
        pet.owner = @owner
        pet.save
      else
        new_pet = Pet.create(params[:pet][:name])
        new_pet.owner = @owner
        new_pet.save
      end
    end
    #pet_name = pets.find(params[:pet][:name]
    #pets.select do |pet|
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do

  end
end
