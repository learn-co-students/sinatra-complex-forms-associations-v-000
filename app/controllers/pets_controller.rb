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
    if !!params[:pet][:owner_id]
      @pet.owner_id = params[:pet][:owner_id].first
    elsif !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    # binding.pry
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    ####### bug fix

    if !params[:pet].keys.include?("owner_id")
    params[:owner]["owner_id"] = []
    end
    #######

    @pet = Pet.find(params[:id])


    @pet.name = params["pet"]["name"]
    @pet.owner_id = params["pet"]["owner_id"].first

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
