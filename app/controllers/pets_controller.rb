class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(:id)
    erb :'pets/edit'
  end

  post '/pets' do

    @pet = Pet.create(name: params[:pet][:name])
    if params[:pet][:owner_id] != nil
      @owner = Owner.find(params[:pet][:owner_id])
    elsif !params[:owner][:name].empty?
      @owner.create(params[:owner][:name])
    end
    @pet.save
    @owner.pets << @pet
    @owner.save

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
