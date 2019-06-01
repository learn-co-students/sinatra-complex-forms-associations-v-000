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

    if params["owner_name"] == ""
      @pet.owner = Owner.find_by(id: params["owner_id"])
      @pet.save
    else
      @pet.owner = Owner.create(name: params["owner_name"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
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

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params["pet_name"])

    if params["owner"]["name"] != ""
      @pet.owner = Owner.new(name: params["owner"]["name"])
      @pet.save
    else
      nil
    end
    redirect to "pets/#{@pet.id}"
  end
end
