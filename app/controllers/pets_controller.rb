class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    @pet.owner = Owner.create(name: params[:owner_name]) if !params[:owner_name].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name]) if !params[:pet][:name].empty?
    @pet.update(owner_id: params[:pet][:owner_id])
    @pet = Pet.find(params[:id])
    @pet.owner = Owner.create(params[:owner]) if !params[:owner][:name].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end