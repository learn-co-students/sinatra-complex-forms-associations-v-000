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
    @pet = Pet.create(name: params["pet_name"])
    if !params["owner_name"].empty?
      owner = Owner.create(name: params["owner_name"])
    else
      owner = Owner.find_by(id: params["pet"]["owner_id"])
    end
      @pet.owner_id = owner.id
      @pet.save
      redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    #binding.pry
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[":id"])
    binding.pry
    @pet.update(name: params["pet_name"])

    if !params["owner_name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
    else
      owner = Owner.find_by(id: params["owner"]["id"])
    end
      @pet.owner_id = owner.id
      @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
