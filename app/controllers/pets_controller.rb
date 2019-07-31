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
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @pet.owner.id
      @pet.save
    else 
      @pet.owner = Owner.find(params["owner"]["id"])
      @pet.owner_id = @pet.owner.id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all 
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    if @pet.owner_id != nil  
      @owner = Owner.find(@pet.owner_id)
    end 
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.owner_id = params["owner"]["id"]
    @pet.name = params["pet"]["name"]
    @pet.save 
    
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id << @pet.owner.id 
      @pet.save  
    end
    redirect to "pets/#{@pet.id}"
  end
end