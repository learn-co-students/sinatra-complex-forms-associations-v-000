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
    @pet = Pet.create(name: params[:pet_name])
    #binding.pry
    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
    else
      #binding.pry
      @pet.owner = Owner.find_by(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    #binding.pry
    @pet.update(name: params[:pet_name])
    #binding.pry
    if !params[:owner][:name].empty?
      #binding.pry
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      #binding.pry
      @pet.owner = Owner.find_by(id: params[:owner][:id])
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end


end
