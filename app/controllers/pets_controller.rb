class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    #name: params[:pet][:name], owner_id: params[:pet][:owner_id][0]
    @pet = Pet.create(params[:pet])
    #binding.pry

    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    elsif !!params[:pet][:owner_id][0]
      @pet.owner_id = params[:pet][:owner_id][0]
    else
    end
    @pet.save
    #binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    #binding.pry
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    #binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(name: params["pet"]["name"])
    #binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    elsif !!params[:pet][:owner_id][0]
      @pet.owner_id = params[:pet][:owner_id][0]
    else

    end
    #binding.pry
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end