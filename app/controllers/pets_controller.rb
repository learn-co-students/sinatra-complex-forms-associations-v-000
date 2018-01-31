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
    @pet = Pet.new
    @pet.name = params["pet"]["name"]
    if !params["owner_name"].empty?
      @pet.owner  = Owner.create(name: params["owner_name"])
    else
      @pet.owner = Owner.find(params["pet"]["owner_id"].first)
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
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
    if !params["owner_name"].empty?
      owner  = Owner.create(name: params["owner_name"])
    else
      owner = Owner.find(params["pet"]["owner_id"].last)
    end
    @pet.update(name: params["pet"]["name"], owner: owner)
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end