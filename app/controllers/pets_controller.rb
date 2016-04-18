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
    @pet.owner_id = params["pet"]["owner_id"]
   
    @pet.save
    #binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    
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
    
    @pet.owner_id = params["pet"]["owner_id"]#.first#.each {|owner| @pet.owner_id = }
       
    #if params["pet"]["owner_id"].length > 1
    #  params["pet"]["owner_id"].each {|owner| @pet.owner = Owner.create(name: params["owner"]["name"])}
    
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end

