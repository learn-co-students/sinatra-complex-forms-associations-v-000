class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params["pet"]["name"])
    unless !params["pet"]["owner_id"] || params["pet"]["owner_id"].empty?
      @pet.update(owner_id: params["pet"]["owner_id"])
      @owner = Owner.find_by(id: params["pet"]["owner_id"])
    end
    unless params["pet"]["owner"].empty?
      @owner = Owner.create(name: params["pet"]["owner"])
      @pet.update(owner_id: @owner.id)
    end
    @owner.pets << @pet
    @owner.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by(id: params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])
    @pet.update(name: params["pet"]["name"])
    unless !params["pet"]["owner_id"] || params["pet"]["owner_id"].empty?
      @pet.update(owner_id: params["pet"]["owner_id"])
      @owner = Owner.find_by(id: params["pet"]["owner_id"])
    end
    unless params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.update(owner_id: @owner.id)
    end
    @owner.pets << @pet
    @owner.save
    redirect to "pets/#{@pet.id}"
  end
end