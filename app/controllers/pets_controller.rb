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
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
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
    erb :'pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet_name]
    @pet.owner = Owner.find(params[:owner_id])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.new(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
