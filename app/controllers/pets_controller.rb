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
    if !!params["pet"]["owner_ids"]
      @pet = Pet.create(name: params["pet"]["name"], owner_id: params["pet"]["owner_ids"][0])
    else
      @owner = Owner.create(params["owner"])
      @pet = Pet.create(name: params["pet"]["name"], owner_id: @owner.id)
    end
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
    if params["owner"]["name"] != ""
      @owner = Owner.create(params["owner"])
      @pet.update(owner_id: @owner.id)
    else
      @pet.update(owner_id: params["pet"]["owner_id"])
    end
    @pet.update(name: params["pet"]["name"])
    redirect to "pets/#{@pet.id}"
  end
end
