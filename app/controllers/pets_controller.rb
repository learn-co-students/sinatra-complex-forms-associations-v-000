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
    @owner = Owner.find_by_id(params[:owner][:id])
    if @owner
      @owner.pets << @pet
    else
      @owner = Owner.create(name: params[:owner][:name])
      @owner.save
      @owner.pets << @pet
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])
    if params[:owner][:name].empty?
      @owner = Owner.find_by_id(params[:owner][:id])
      @owner.pets << @pet
    else
      @owner = Owner.create(name: params[:owner][:name])
      @owner.save
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end
end

