class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets' do
    @pet = Pet.new
    @pet.name = params["pet"]["name"]
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @owner.id
      @pet.save
    else
      @pet.owner_id = params["pet"]["owner_ids"][0]
      @pet.save
      @owner = Owner.find(params["pet"]["owner_ids"][0])
    end
    @owner.pets << @pet
    @owner.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.name = params["pet"]["name"]
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @owner.id
      @pet.save
    else
      @pet.owner_id = params["pet"]["owner_ids"].last
      @pet.save
      @owner = Owner.find(params["pet"]["owner_ids"].last)
    end
    @owner.pets << @pet
    @owner.save
    redirect to "pets/#{@pet.id}"
  end
end
