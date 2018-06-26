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
    @owner = Owner.find(params[:owner_id]) if params.has_key?(:owner_id)
    @owner = Owner.create(name: params[:owner_name]) if !params[:owner_name].empty?
    @owner.pets << @pet
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    @owner = Owner.find(params["owner"]["name"])
    @owner = Owner.create(name: params[:owner_name]) if !params[:owner_name].empty?
    @owner.pets << @pet
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
end
