require 'pry'

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
    @pet = Pet.create(name: params[:pet][:name])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    else
      @pet.owner = Owner.find_by_id(params[:pet][:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])

    if !params[:owner][:name].empty?
      @pet.update(owner: Owner.create(name: params[:owner][:name]))
    else
      @pet.update(owner: Owner.find_by_id(params[:pet][:owner]))
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
end
