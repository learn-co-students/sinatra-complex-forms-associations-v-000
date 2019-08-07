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
    # I chose to create the pet (with the existing owner that the user selected), then change its owner if a new owner is specified. That fixes this problem:
    # I can't use a radio button for the new owner, so the user could choose an existing owner AND create a new one.
    
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
  
  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all 
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    
    if params[:owner][:name].blank?
      @pet.update(params[:pet])
    else
      @new_owner = Owner.create(params[:owner])
      @pet.update(name: params[:pet][:name], owner: @new_owner)
    end

    redirect to "pets/#{@pet.id}"
  end
end