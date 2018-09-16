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
    @pet = Pet.create(params["pet"])
    # binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    # binding.pry
    @pet.save
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params['id'])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params['id'])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params['id'])
    ####### bug fix
    if !params["pet"].keys.include?("owner_ids")
    params["pet"]["owner_ids"] = []
    end
    #######
    @pet.update(params["pet"])
    # @pet.name = params["pet"]
    # @pet.save

    if !params["owner"]["name"].empty?
      @opet.owners << Owner.create(name: params["owner"]["name"])
    end
    redirect "/pets/#{@pet.id}"
  end
end
