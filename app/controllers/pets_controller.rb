class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(:name => params["pet_name"])
    if !params["owner_name"].empty?
      @pet.build_owner(:name => params["owner_name"])
    else
      @pet.owner = Owner.find(params["owner_id"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
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
    @pet.update(:name => params["pet_name"])
    if !params["owner"]["name"].empty?
      @pet.build_owner(params["owner"])
    else
      @pet.owner = Owner.find(params["owner_id"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end
end