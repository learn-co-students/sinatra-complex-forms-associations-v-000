class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners =  Owner.all
    erb :'/pets/new'
  end

  post '/pets' do

      if !params[:owner_name].empty?
        @pet = Pet.create(params[:pet])
        @owner = Owner.create(name: params[:owner_name])
        @pet.owner = @owner
        @pet.save
      else
        @pet = Pet.create(params[:pet])
        @owner= Owner.create(params[:owner])
        @pet.owner = @owner
        @pet.save
      end

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
       @owner = Owner.create(name: params["owner_name"])
       @pet.owner = @owner
     else
       @pet.name = params["pet"]["name"]
       @pet.owner = Owner.find_by(name: params["owner"]["name"])
     end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
