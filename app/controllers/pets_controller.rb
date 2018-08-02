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
    binding.pry
    @pet = Pet.create(params[:pet])
    if params["owner"]["name"].empty?
      @pet.owners << Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}/show"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
  @pets = Pet.find(params[:id])
  @pets.update(params["owner"])
    if !params["owner"]["name"].empty?
      @pet.owners << Owner.create(name:params["owner"]["name"])
    end
    redirect to "pets/#{@pet.id}"
  end

end
