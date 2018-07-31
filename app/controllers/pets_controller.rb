class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    binding.pry
    @owners = Owner.all

    erb :'/pets/new'
  end

  post '/pets' do

    pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])

    redirect to 'pets/#{@pet.id}'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])


    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
