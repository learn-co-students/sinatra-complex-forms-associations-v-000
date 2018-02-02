class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/' do
    redirect '/pets'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets/new' do
    @pet = Pet.create(params[:pet])
    @owner = Owner.find_by(params[:owner_name])
    if !!@owner
      @pet.owner_id = @owner.id
    elsif !!params[:owner_name]
      @owner = Owner.create(params[:owner_name])
      @pet.owner_id = @owner.id
    end
    @pet.save
    binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "pets/#{@pet.id}"
  end
end
