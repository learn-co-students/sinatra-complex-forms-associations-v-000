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
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
      @owner.pets << @pet
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
    binding.pry
    @pet = Pet.find(params[:id])
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
      @pet.update(name: params["pet[name]"], owner_id: params["owner_name"])
      @owner.pets << @pet
    else
      @pet.update(name: params["pet[name]"], owner_id: params["owner[name]"])
    end
    redirect to "pets/#{@pet.id}"
  end
end
