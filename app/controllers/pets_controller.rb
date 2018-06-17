class PetsController < ApplicationController

  get '/pets' do #shows all pets
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do #shows a form to submit a new pet
    erb :'/pets/new'
  end

  post '/pets' do #creates a new instance of pet and redirects user to that pet's page
    #binding.pry
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty? #&& @pet.owner == ""
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end
end
