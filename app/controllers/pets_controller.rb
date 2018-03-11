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
    if params[:owner][:id]
      owner = Owner.find(params[:owner][:id])
    else
      owner = Owner.create(params[:owner])
    end

    pet = Pet.new(params[:pet])
    pet.owner = owner
    pet.save

    redirect to "pets/#{pet.id}"
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
    if params[:owner][:name] != ""
      owner = Owner.create(params[:owner])
    else
      owner = Owner.find(params[:pet][:owner_id])
    end
    #binding.pry

    @pet.update(params[:pet])
    @pet.owner = owner
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
