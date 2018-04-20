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
    if !params["owner"]["name"].empty? # if little boxes are filled with name alredy
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

# updating part of the code
  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])

    if !params["pet"]["name"].empty?
      # = because a cat only has 1 owner
      @pet.owner = Owner.create(name: params["owner"]["name"])
     end
    redirect to "pets/#{@pet.id}"
  end
end
