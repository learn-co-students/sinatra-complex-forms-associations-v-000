require 'pry'

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owner = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params["pet_name"], owner_id: params["owner_id"])

    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.owner = Owner.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @pet.owner = Owner.find(params[:id])
    #binding.pry
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    binding.pry
    @pet.update(name: params["pet_name"])
    #binding.pry
    @pet.owner.update(name: params[:owner]["name"])

    if !params["owner_name"].empty?
      #binding.pry
      @pet.owner = Owner.create(name: params["owner_name"])
    end
    #binding.pry

    redirect to "pets/#{@pet.id}"
  end
end
