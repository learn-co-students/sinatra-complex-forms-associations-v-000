class PetsController < ApplicationController

  get '/pets' do
    # @owners = Owners.all
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    # binding.pry
    @pet = Pet.create(params[:pet])
    # binding.pry

    if !params["owner"]["name"].empty?
      # binding.pry
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    # binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    # binding.pry
    @pet = Pet.find(params[:id])
    # binding.pry

    @pet.update(params["pet"])
    # binding.pry
    if !params["owner"]["name"].empty?
      # binding.pry

      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end


end
