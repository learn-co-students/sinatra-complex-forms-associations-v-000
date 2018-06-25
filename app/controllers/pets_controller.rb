class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owner = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params["pet_name"])
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
      @pet.owner_id = @owner.id
      @pet.save
    elsif !params["pet"]["owner_id"].empty?
      @pet.owner_id = params["pet"]["owner_id"][0]
      @pet.save
    end
    redirect to "/pets/#{@pet.id}"
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
    @pet.update(name: params["pet_name"])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @owner.id
      @pet.save
    elsif !params["pet"]["owner_id"].empty?
      @owner = Owner.find(params["pet"]["owner_id"][0])
      @pet.owner_id = @owner.id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
