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
    #binding.pry
    @owner = Owner.create(params[:owner]) #creates a new owner
    pets = Pet.all
    pets.detect do |pet|
      if pets
        pet.owner = @owner
        pet.save
      else
        @pet = Pet.new(params[:pet][:name])
        @pet.owner = @owner
        @pet.save
      end
      @owner
    end
    redirect to "pets/#{@owner.id}"
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
