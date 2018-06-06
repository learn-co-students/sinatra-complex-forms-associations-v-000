class PetsController < ApplicationController

  get '/pets' do
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all

    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet_name])
    if !params[:owner_id].empty?
      @pet.owner_id = params[:owner_id]
    end
    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params['owner']['name'])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
