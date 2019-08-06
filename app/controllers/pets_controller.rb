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
    # It wouldn't hurt to create the pet, then change its owner if a new owner is specified. That fixes this problem:
    # I can't use a radio button for the new owner, so the user can choose an existing owner AND create a new one.
    
    @pet = Pet.create(params[:pet])
    unless params[:owner][:name].blank?
      @owner = Owner.create(params[:owner])
      @owner.pets << @pet
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end