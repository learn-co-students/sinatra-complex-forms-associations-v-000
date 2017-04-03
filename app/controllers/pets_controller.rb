class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet= Pet.create(params[:pet])
    @pet.owner = Owner.find_by_id(params[:pet][:owner_id][0])
    @pet.save
    if params[:owner][:name].size > 0

      @pet.owner = Owner.create(name: params["owner"]["name"][0])
      @pet.save
    end
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
