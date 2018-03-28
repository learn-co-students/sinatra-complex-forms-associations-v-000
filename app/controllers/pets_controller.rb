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
    if !!params[:pet][:owner_id]
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    else
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    @pet.owner = Owner.find_or_create_by(name: params[:owner][:name]) if !params[:owner][:name].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end