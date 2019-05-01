require 'pry'

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do #renders new
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:name])
    #binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner << Owner.create(name: params["owner"]["name"])
    else
      @owner = Owner.create(params["owner"]["name"])

    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  patch '/pets/:id' do #edit
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end

    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner << Pet.create(name: params["owner"]["name"])
    end

    redirect to "pets/#{@pet.id}"
  end
end
