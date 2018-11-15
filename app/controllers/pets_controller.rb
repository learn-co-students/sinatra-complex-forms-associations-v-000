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
    @owner = Owner.find_by(id: params[:pet][:owner_id])
    @pet.owner = @owner

    if params[:pet][:owner_id] == nil || params[:pet][:owner_id] == ""
      @owner = Owner.create(name: params[:owner][:name])
      @pet.owner = @owner
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pets = Pet.all
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !(params["owner"]["name"]).empty?
      @owner = Owner.create(params["owner"])
      @pet.owner = @owner
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

end
