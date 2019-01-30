class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(:name =>params["pet_name"])
    if params["owner"] == nil
      @pet.owner = Owner.create(:name => params["owner_name"])
      @pet.save
    else
      @pet.owner = Owner.find_by(id: params["owner"])
      @pet.save  
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

  patch '/pets/:id' do
    #binding.pry
    ####### bug fix
    @pet = Pet.find(params[:id])
 #   binding.pry
    if params[:owner][:name].length >= 2 
    @pet.name = params[:pet_name]
    @owner = Owner.create(name: params[:owner][:name])
    @pet.owner = @owner
    @pet.save
    #######
    else
    @pet.name = params[:pet_name]
    @pet.owner = Owner.find(params[:owner_id])
    @pet.save
    end
    redirect "pets/#{@pet.id}"
  end
  
end