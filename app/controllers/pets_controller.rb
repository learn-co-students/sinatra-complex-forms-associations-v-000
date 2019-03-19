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
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
      @pet.owner = @owner
      @owner.save
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    ####### bug fix
    if !params[:pets].keys.include?("owner_id")
    params[:pets]["owner_id"] = []
    end
    #######
    @owners = Owner.find(params[:id])
    @owners.update(params["owner"])
    if !params["owner"]["name"].empty?
      @owners.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "pets/#{@pet.id}"
  end
end
