class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params['owner']['name'].empty?
      owner = Owner.create(name: params["owner"]["name"])
      owner.pets << @pet
      @pet.owner_id = owner.id
      @owner.save
      @pet.save
    else
      owner_id = Owner.find_by_id(params[:pet][:owner_id])
      @pet.owner_id = owner_id.id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])

    if !params["owner"]["name"].empty?
      @owner = Owner.create(params['owner'])
      @owner.pets << @pet
      @pet.owner = @owner
    end
    @pet.save
    redirect to "/pets/#{@pet.id}"
  end


end
