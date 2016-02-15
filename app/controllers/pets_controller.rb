class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet][:name])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    else
      @pet.owner = Owner.find(params[:pet]["owner_ids"].first)
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
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      @pet.owner = Owner.find(params[:pet]["owner_ids"].last)
    end
    @pet.save
    #binding.pry
    redirect to "pets/#{@pet.id}"
  end
end
