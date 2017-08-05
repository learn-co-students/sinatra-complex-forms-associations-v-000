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
    #CREATING NEW PETS WITH ASSOCIATED OWNERS IN THE CONTROLLER
      @pet = Pet.create(params[:pet])
    #create an if statement to check whether or not the value of params["owner"]["name"] is an empty string.
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    owner = @pet.owner
    @pet.save
  redirect to "pets/#{@pet.id}"
  end

#SET variable
#GET variable
#DEFINE function(method)
#EXECUTE function(method)

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
