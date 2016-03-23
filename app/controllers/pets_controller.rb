class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    # binding.pry
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  # edit
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    elsif params["owner"]["id"] != @pet.owner.id
      @pet.owner = Owner.find_by_id(params[:owner][:owner_id])
    end
    @pet.name = params[:pet][:name]
    @pet.save
    redirect to "/pet/#{@pet.id}"
  end
end
