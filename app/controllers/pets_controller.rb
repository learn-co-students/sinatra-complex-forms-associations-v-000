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
    pet = Pet.create(name: params["pet"]["name"])

    if !params["owner"]["name"].empty?
      owner = Owner.create(params["owner"])
      pet.owner = owner
      pet.save
    elsif params["pet"]["owner_id"]
      pet = Pet.create(name: params["pet"]["name"], owner_id: params["pet"]["owner_id"])
    else
      redirect to '/pets/new'
    end

    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    @pet = Pet.find_by(id: params[:id])

    if !params["owner"]["name"].empty?
      owner = Owner.create(params["owner"])
      @pet.owner = owner
      @pet.save
    elsif params["pet"]["owner_id"]
      @pet.name = params["pet"]["name"]
      @pet.owner_id = params["pet"]["owner_id"]
      @pet.save
    end

    redirect to "pets/#{params[:id]}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by(id: params[:id])

    erb :'/pets/edit'
  end

end