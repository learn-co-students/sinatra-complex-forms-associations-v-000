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
    if params["name"].empty?
      @owner = Owner.find(params[:owner])
      @owner.pets << @pet
    else
      @owner = Owner.create(:name => params[:name])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

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
    @pet.update(name: params[:pet_name])
    if params["owner"]["name"].empty?
      @pet.update(params["pet"])
    else
      @owner = Owner.create(params[:owner])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end
end