class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet= Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    #binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'

  end

  post '/pets/:id' do
    #binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name], owner_id: params[:owner_id])
    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
      @pet.update(name: params[:pet_name], owner_id: @pet.owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end
end
