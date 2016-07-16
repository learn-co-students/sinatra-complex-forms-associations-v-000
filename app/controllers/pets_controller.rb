class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @owner.pets << @pet
    end
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
    @pet.update(name: params[:pet_name], owner_id: params[:owner_id])
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @owner.pets << @pet
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
