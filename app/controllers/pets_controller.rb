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
    @pet = Pet.create(name: params[:name])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      @pet.owner = Owner.find(params[:pet][:owner_id])
    end
    @pet.name = params[:pet][:name]
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])

    erb :'/pets/edit'
  end

end