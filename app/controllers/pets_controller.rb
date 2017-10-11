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

    if !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner])
      @owner.pets << @pet
    else
      @owner = Owner.find_by_name(params[:owner_name])
      @owner.pets << @pet
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])

    erb :'pets/edit'
  end


  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    @pet = Pet.find(params[:id])

    if params["pet"]["name"] != @pet.name
      @pet.update_attribute(:name, params["pet"]["name"])
    end

    if !params["owner"]["name"].empty?
      @owner = Owner.create(params[:owner])
    else
      @owner = Owner.find_by_name(params[:owner_name])
    end

    @owner.pets << @pet
    @owner.save

    redirect to "pets/#{@pet.id}"
  end
end
