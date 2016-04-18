class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    #\binding.pry
    @pet = Pet.create(params[:pet])
    @pet.owner_id = params["pet"]["owner_id"].first
    #binding.pry
    @pet.save
    #if @pet.owner
    binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    #binding.pry
    @pet.save
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
    @pet = Pet.find(params[:id])
    @pet.name = params['pet']['name']
    
    @pet.owner_id = params["pet"]["owner_id"].first
    

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end


    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end

