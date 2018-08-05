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
    # binding.pry
    if !params["pet"]["owner_name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
      # @pet.owner =
    end
    @owner.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    # binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
