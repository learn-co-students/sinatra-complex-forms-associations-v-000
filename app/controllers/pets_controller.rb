class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owner = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params["pet_name"])
    @owner = Owner.find_by_id(params["pet"]["owner_id"])
      if @owner
        @owner.pets << @pet
        @pet.owner = @owner
      end
      if !params["owner_name"].empty?
         @new_owner = Owner.create(name: params["owner_name"])
         @new_owner.pets << @pet
         @pet.owner = @new_owner
      end
    @pet.save
    redirect to "pets/#{@pet.id}"
    end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
       @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
  end
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["pet_name"].empty?
      Pet.create(name: params["pet_name"])
    end
    redirect to "pets/#{@pet.id}"
  end
end
