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
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

end
