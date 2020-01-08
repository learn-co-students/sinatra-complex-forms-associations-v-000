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
     #binding.pry
     @pet = Pet.create(params[:pet])
     if !params["owner"]["name"].empty?
       owner = Owner.create(params["owner"])
       @pet.owner_id = owner.id
     end
     @pet.save
     redirect "/pets/#{@pet.id}"
  end
       
       #@pet.owner.name = << Owner.create(params["owner"]["name"])
     #if !params["owner"]["name"].empty?
      #@pet.owner = Owner.create(name: params["owner"]["name"])
    #end
    #redirect "/pets/#{@pet.id}"
  #end

  #post '/pets/' do
    #binding.pry
    #@owner = Owner.find(params["pet"]["owner_id"][0])
    #@pet = Pet.create(params[:pet])
    #@owner.pets.build(params[:pet])
    #@owner.save
    #@owner = Owner.find(params[:owner_id])
    #@pet = Pet.create(params[:pet])
    #if params[:owner_id] == nil
    #if params["owner"]["name"] == nil
      
      
      
    #if !params["owner"]["name"].empty?
      #@pet.owner = Owner.create(name: params["owner"]["name"])
    #end
    #redirect to "/pets/#{@pet.id}"
#  end
  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end
end