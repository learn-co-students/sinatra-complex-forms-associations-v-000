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
    if params[:owner_name].empty?
      @owner = Owner.find_by(id: params[:pet][:owner_ids].first.to_i)
      @pet = Pet.create(name: params[:pet][:name], owner: @owner)
      @owner.pets << @pet
    else
      @owner = Owner.create(name: params[:owner_name])
      @pet = Pet.create(name: params[:pet][:name], owner: @owner)
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
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
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
end
