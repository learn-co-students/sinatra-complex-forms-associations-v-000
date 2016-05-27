require 'pry'

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(params["owner"])
      @pet.owner_id = @owner.id
      @owner.pets << @pet     
    else
      @owner = Owner.find_by_id(params["pet"]["owner_id"])
      @owner.pets << @pet 
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
    @pet = Pet.find(params[:id])
    @owner = Owner.find_by_id(params["pet"]["owner_id"])
    @pet.owner_id = @owner.id
    @pet.update
    if !params["owner"].empty?
      @owner = Owner.create(params["owner"])
      @pet.owner_id = @owner.id
      @owner.pets << @pet
    end
    binding.pry
    #redirect to "pets/#{@pet.id}"
  end

end



