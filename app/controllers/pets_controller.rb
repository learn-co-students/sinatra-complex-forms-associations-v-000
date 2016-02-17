class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    #binding.pry
    @pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    if !(params[:owner][:name]).empty?
      @owner = Owner.create(name: params[:owner][:name])
      @pet.owner_id = @owner.id
    end
    @pet.save
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
  #binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.update(owner_id: @owner.id)

    end
    redirect to "pets/#{@pet.id}"
  end
end
