class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params["pet"])
  
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      @pet.owner = Owner.find(params["pet"]["owner_id"]).first
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
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])

    @pet.update(name: params["pet"]["name"], owner_id: params["pet"]["owner_ids"].last)
    if !params["owner"]["name"].empty?
      @pet.update(owner: Owner.create(name: params["owner"]["name"]))
    end
    redirect to "pets/#{@pet.id}"
  end
end