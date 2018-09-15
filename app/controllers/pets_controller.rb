class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Owner.create(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owners << Pet.create(name: params["owner"]["name"])
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    ####### bug fix
    if !params["pet"].keys.include?("owner_ids")
    params["pet"]["owner_ids"] = []
    end
    #######

    @pet.update(params["pet"])

    if !params["owner"]["name"].empty?
      @opet.owners << Owner.create(name: params["owner"]["name"])
    end
    redirect to "pets/#{@pet.id}"
  end
end
