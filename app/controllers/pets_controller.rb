class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet]) #mass assignment: successfully associates new owner with existing pets whose ID numbers were in the params hash
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"]) #create new owner & add its foreign key to this pet
    end
    @pet.save
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
    @pet.update(params["pet"]) #mass assignmet to update pet
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save #to make sure owner reassignment above is saved
    redirect to "pets/#{@pet.id}"
  end

end