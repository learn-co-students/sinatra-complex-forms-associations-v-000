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
    if !params["owner_name"] == ""
      @pet.owner = Owner.create(name: params["owner_name"])
      binding.pry
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    ##### bug fix
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
    #####

    @pet = Pet.find(params[:id])
    @pet.udpate(params["pet"])
    if !params["owner_name"] == ""
      @pet.owners = Owner.create(name: params["owner_name"])
    end
    redirect to "pets/#{@pet.id}"
  end
end
