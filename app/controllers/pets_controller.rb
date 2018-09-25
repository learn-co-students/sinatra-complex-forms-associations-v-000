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
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @owner = Owner.new(name: params["owner"]["name"])
      @pet.owner = @owner
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end


  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"]) #updates owner_id
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @owner.pets << @pet #can't just save @pet.owner, need to tell owner about it
    end
    redirect to "pets/#{@pet.id}"
  end

end
