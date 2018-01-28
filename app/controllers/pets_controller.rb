require 'pry'
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    if !params[:owner_name].empty?
      @new_owner = Owner.create(name: params["owner_name"])
      @pet = Pet.create(name: params["pet"]["name"], owner_id: @new_owner.id)
    else
      @pet = Pet.create(name: params["pet"]["name"], owner_id: params["pet"]["owner_id"])
    end
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
    if !params[:owner_name].empty?
      @new_owner = Owner.find_by(name: params["owner_name"])
      @pet = Pet.update(name: params["pet"]["name"], owner_id: @new_owner.id)
    else
      @pet = Pet.update(name: params["pet"]["name"], owner_id: params["pet"]["owner_id"])
    end
    redirect to "pets/#{@pet.id}"
  end
end