class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if params["owner"]
      @pet.owner = Owner.find_by(id: params["owner"])
    else !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
      @pet.owner.save
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
    @pet.update(params["pet"])
    if params["owner"]["id"]
      owner = Owner.find_by(id: params["owner"]["id"])
      @pet.update(owner: owner)
    else params["owner"]["name"]
      owner = Owner.create(params["owner"])
      @pet.update(owner: owner)
    end
    redirect to "pets/#{@pet.id}"
  end
end
