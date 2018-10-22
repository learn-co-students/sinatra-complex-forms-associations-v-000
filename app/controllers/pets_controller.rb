class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all

    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
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


  post '/pets' do 

    @pet = Pet.create(name: params["pet_name"])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    else
      @pet.owner = Owner.find(params["pet"]["owner_ids"].first)
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.name = params["pet_name"]
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    else
      @pet.owner = Owner.find(params["owner"]["name"].first)
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end