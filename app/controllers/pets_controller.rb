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
    # want to create a new pet based on params
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty? # meaning its not empty - meaning you are creating the owner now
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = owner.id
    else 
      owner_id = params["owner"]["owner_ids"].join.to_i
      @pet.owner_id = owner_id 
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
    erb :'pets/edit'
  end

  post '/pets/:id' do 

    @pet = Pet.find(params[:pet])
    @pet.update(params["pet"])
 
    if params["owner"]["owner_ids"]
      @pet.owner_id = params["owner"]["owner_ids"].join.to_i
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end

#need to ask an expert how i can binding pry and get to the bottom of this