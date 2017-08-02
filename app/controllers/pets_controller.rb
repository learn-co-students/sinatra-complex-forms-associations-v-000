class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners =  Owner.all
    erb :'/pets/new'
  end

  post '/pets' do

      @pet = Pet.create(params[:pet])
      @owner = Owner.create(name: params[:owner_name])
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
