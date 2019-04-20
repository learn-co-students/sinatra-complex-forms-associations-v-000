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
    @owner = Owner.create(params["owner"])
    #binding.pry
    pet = Pet.new(params[:pet]) #instantiate a new pet
    pet.owner = @owner #association
    pet.save
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
