class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets' do
    # binding.pry
    if params[:pet][:owner_ids]
      owner = Owner.find(params[:pet][:owner_ids].first)
    else
      owner = Owner.create(name: params[:owner_name])
    end
    # binding.pry
    pet = owner.pets.create(name: params[:pet][:name])
    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    pet = Pet.find(params[:id])
    unless params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
    else
      owner = Owner.find(params[:pet][:owner_ids].last)
    end
    pet.update(name: params[:pet][:name], owner: owner)
    redirect to "pets/#{pet.id}"
  end
end
