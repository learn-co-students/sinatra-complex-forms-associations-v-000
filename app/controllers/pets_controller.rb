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
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @owner.save
    else
      @owner = Owner.find_by_id(params[:pet][:owner_id])
    end
    @pet = Pet.create(name: params[:pet_name], owner_id: @owner.id)
    @pet.save
    #binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner_name = Owner.find(@pet.owner_id)
    erb :'/pets/show'
  end

  post '/pets/:id' do
    #@pet.name = params[:name]
    @pet = Pet.find(params[:id])
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @owner.save
      @pet.update(owner_id: @owner.id)
      @pet.save
    end
    if !params[:pet_name].empty?
      @pet.update(name: params[:pet_name])
      @owner = Owner.find_by_id(params[:owner_id])
      @pet.save
    end
    # @pet.update(name: params[:pet_name], owner_id: @owner.id)
    # @pet.update(params["owner"])
    # if !params["pet"]["name"].empty?
    #   @owner.pets << Pet.create(name: params["pet"]["name"])
    # end
    redirect to "pets/#{@pet.id}"
  end
end
