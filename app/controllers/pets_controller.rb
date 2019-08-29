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

    @pet = Pet.create(params["pet"])

    if !params["owner"]["name"].empty?
      #@pet.owner = Owner.create(name: params["owner"]["name"])
      @owner = Owner.create(name: params["owner"]["name"])
      @owner.pets << @pet
    end
# binding.pry
    redirect to "pets/#{@pet.id}"

  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :"/pets/edit"
  end

  patch '/pets/:id' do
    ####### bug fix
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
    #######

    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @owner.pets << @pet
    end
    redirect "pets/#{@pet.id}"
  end
end
