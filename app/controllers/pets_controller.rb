class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params["pet"])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @owner.pets << @pet
      @owner.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet][:name] if !params[:pet][:name].empty?
    @pet.owner = Owner.find(params[:pet][:owner_ids])
    @pet.save

    if params["owner"]["name"] != ""
      @owner = Owner.create(name: params["owner"]["name"])
      @owner.pets << @pet
      @owner.save
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
end
