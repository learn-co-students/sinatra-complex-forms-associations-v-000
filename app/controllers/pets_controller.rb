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
    #binding.pry
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      @pet.owner = Owner.find_by(id: params[:owner_id])
    end
    @pet.save
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
      @pet = Pet.find(params[:id])
      #binding.pry
      erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.owner = Owner.find_by(id: @pet.owner_id)
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      @pet.owner = Owner.find_by(id: params[:owner_id])
    end
    @pet.save
    redirect to "/pets/#{@pet.id}"
  end
end
