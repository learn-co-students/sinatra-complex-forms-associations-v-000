class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    # create pet
    @pet = Pet.create(params[:pet])
    # if There is an Owner name, create the owner
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(params[:owner])
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

    # raise params.inspect
    #find the pet
    @pet = Pet.find(params[:id])
    # update pet name
    @pet.update(params[:pet])
    # If there is an Owners Name, Update that too...
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

end
