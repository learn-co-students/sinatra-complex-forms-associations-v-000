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
    if params["owner"]["name"].empty?
      @owner = Owner.find(params["pet"]["owner_id"])
    else
      @owner = Owner.create(params[:owner])
      params[:pet][:owner_id] = @owner.id
    end
    @pet = Pet.create(params[:pet])
    #if !params["pet"]["name"].empty?
    @owner.pets << @pet
    #end
    redirect to "/pets/#{@pet.id}"
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

    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      params["pet"]["owner_id"] = @owner.id
    end
    #binding.pry
    @pet.update(params["pet"])
    redirect to "/pets/#{@pet.id}"
  end
end
