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
    @pet = Pet.create(name: params[:pet_name])
    # binding.pry
    if params[:owner_id]
      @pet.owner = Owner.find(params[:owner_id])
    else
      @pet.owner = Owner.create(name: params[:owner_name], pets: @pet)
    end
    @pet.owner
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 

    redirect "pets/#{@pet.id}"
  end
end