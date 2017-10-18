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
    @pet = Pet.create(params["pet"])
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
    else
      owner = Owner.find_by_id(params["pet"]["owner_id"])
    end
    owner.pets << @pet
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
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
    else
      owner = Owner.find_by_id(params["pet"]["owner_id"])
    end
    owner.pets << @pet if !owner.pets.include?(@pet)
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
