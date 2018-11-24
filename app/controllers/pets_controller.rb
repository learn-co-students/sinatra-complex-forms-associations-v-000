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
    #binding.pry
    if !params["owner_name"].empty?
      #binding.pry
      @owner = Owner.create(name: params["owner_name"])
      @owner.pets << @pet
      #binding.pry
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    #binding.pry
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    @pet = Pet.find(params[:id])
    #if !params[:pet].keys.include?("owner_id")
      #@owner = Owner.find(params["owner_id"])
    #end
    #binding.pry
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save

  #  @owners = Owner.all
      #@owner = Owner.create(name: params["owner_name"])
      #@owner.pets << @pet

    redirect "pets/#{@pet.id}"
  end
end
