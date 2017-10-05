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
    # binding.pry
    @pet = Pet.create(name: params[:pet][:name]) #doesn't know wth owner_id is
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @pet.owner = @owner
    else
      @pet.owner_id = params[:pet][:owner_id][0]
    end
    @pet.save
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
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @pet.owner = @owner
    else
      @pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id][0])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

end
