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
    if params["owner_name"] != ""
      @owner = Owner.create(name: params["owner_name"])
    else
      @owner = Owner.find(params[:owner_id])
    end
    @pet = Pet.create(name: params["pet_name"],owner_id: params["owner_id"])
    @pet.owner = @owner
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
