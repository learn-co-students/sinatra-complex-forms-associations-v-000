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
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
      owner.pets << @pet
      owner.save
    else
      @pet.owner = Owner.find_by_id(params[:owner_id])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      owner = Owner.create(params[:owner])
      owner.pets << @pet
    else
      @pet.owner = Owner.find(params["owner_id"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
