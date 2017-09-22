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
    owner = Owner.create(name: params["owner"]["name"])
    @pet.update(owner: owner)
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
    #@owner = @pet.owner
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])  #<- it looks like you just forgot the params part 
    #@pet.update(name: params["pet"]["name"])
  #  owner = Owner.find(params["owner_id"])
  #  @pet.update(owner: owner)
     if !params["owner"]["name"].empty?
       @pet.owner = Owner.create(name: params["owner"]["name"])
       #@pet.update(owner: owner)
     end

     @pet.save #need to save the pet
    redirect to "pets/#{@pet.id}"
  end
end
