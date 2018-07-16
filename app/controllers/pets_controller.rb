require 'pry'
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
    @pet = Pet.create(name: params["pet"]["name"])
    if params["pet"]["owner_id"]
      @pet.owner = Owner.find(params["pet"]["owner_id"])
    elsif params["owner"]["name"] != ""
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params["pet"]["name"])

    if params["owner"]["name"] != ""
      @pet.owner = Owner.create(name: params["owner"]["name"])
    elsif params["pet"]["owner_id"]
      @pet.owner = Owner.find(params["pet"]["owner_id"])
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end