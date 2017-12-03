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
    if params[:pet][:owner_name].empty?
      @pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    else
      @pet = Pet.create(name: params[:pet][:name])
      @pet.owner = Owner.create(name: params[:pet][:owner_name])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    if params[:pet][:owner_name].empty?
      @pet = Pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id]).first
    else
      @pet = Pet.update(name: params[:pet][:name]).first
      @pet.owner = Owner.create(name: params[:pet][:owner_name])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
end
