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
    @pet = Pet.create(params[:name])
    @owner = nil
    if !params["owner[name]"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
    else
      if !params["pet[owner]"].empty?
        @owner = Owner.find(params["pet[owner]"][0])
      end
    end
    @pet.owner = @owner
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
