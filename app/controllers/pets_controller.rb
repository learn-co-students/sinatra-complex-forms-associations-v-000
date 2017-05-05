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
    else
      @owner = Owner.find(params[:pet][:owner_id])
    end

    @owner.pets << @pet
    @owner.save

    redirect "/pets/#{@pet.id}"
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
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
    else
      @owner = Owner.find(params[:pet][:owner_id])
    end
    @owner.pets << @pet
    @owner.save

    redirect "/pets/#{@pet.id}"
  end
end
