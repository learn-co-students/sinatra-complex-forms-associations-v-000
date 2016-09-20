class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet][:name])
    if !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
      @pet.owner = owner
    else
      @pet.owner = Owner.find_by_id(params[:pet][:owner][0])
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
    @pet = Pet.find_by_id(params[:id])
    @pet.name = params[:pet][:name]
    if !params[:new_owner][:name].empty?
      owner = Owner.create(name: params[:new_owner][:name])
      @pet.owner = owner
    else
      @pet.owner = Owner.find_by(name: params[:owner]["name"]) 
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end





