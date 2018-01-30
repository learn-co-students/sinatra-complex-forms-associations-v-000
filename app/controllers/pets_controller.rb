require 'pry'

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners=Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if !params["owner"]["name"].empty?
      @pet = Pet.create(name: params["pet"]["name"])
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    else
      #binding.pry
      @pet = Pet.create(name: params["pet"]["name"], owner_id: params["pet"]["owner"]["id"])
  end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    if !params["owner"]["name"].empty?
      @pet = Pet.update(name: params["pet"]["name"])
      @pet[0].owner = Owner.create(name: params["owner"]["name"])
      @pet[0].save
    else
      #binding.pry
      @pet = Pet.update(name: params["pet"]["name"], owner_id: params["pet"]["owner_id"])
    end
    redirect to "pets/#{@pet[0].id}"
  end
end
