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
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
      new_owner = Owner.create(name: params["owner_name"])
      @pet.owner_id = new_owner.id
      new_owner.pets << @pet
    else 
      @pet.owner_id = params[:owner][:id]
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner_name"].empty?
      new_owner = Owner.create(name: params["owner_name"])
      @pet.owner_id = new_owner.id
      new_owner.pets << @pet
    else 
      owner = Owner.find_by_id(params[:owner][:id])
      @pet.owner_id = owner.id
      # @pet.owner_id = params[:owner][:id]
      owner.pets << @pet
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
  
  
end