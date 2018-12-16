class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
      #binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets' do

    @pet = Pet.new(name: params[:pet][:name])

    if params[:pet][:owner_ids] == nil
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      @pet.owner = Owner.find(params[:pet][:owner_ids])[0]
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])


    redirect to "pets/#{@pet.id}"
  end
end
