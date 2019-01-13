class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all

    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])

    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      owner.pets << @pet
    end

    redirect to "/pets/#{@pet.id}"
  end

   get '/pets/:id' do
    @pet = Pet.find(params[:id])

    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])

    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      owner.pets << @pet
    end

    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])

    erb :'/pets/edit'
  end
end
