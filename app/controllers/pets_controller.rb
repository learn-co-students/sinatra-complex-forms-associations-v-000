class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet])
    if params["owner"]["name"] != ""
      @pet.owner = Owner.find_or_create_by(name: params["owner"]["name"])
    end
    if @pet.save
      redirect to "pets/#{@pet.id}"
    else
      erb :'pets/new'
    end
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.find_or_create_by(name: params["owner"]["name"])
    end
    if @pet.save
      redirect to "pets/#{@pet.id}"
    else
      erb :'pets/:id/edit'
    end
  end
end
