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
    if !params["owner_name"].empty?
      new_owner = Owner.create(name: params["owner_name"])
      @pet.owner_id = new_owner.id
    else
      @pet.owner_id = params[:owner][:ids]
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
    @owner = Owner.find_by_id(@pet.owner_id)
    erb :'pets/edit'
    # redirect to "pets/#{@pet.id}"
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "owners/#{@owner.id}"
  end
end
