class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'pets/edit'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet][:name])
    if params[:pet][:owner_id] != nil
      @owner = Owner.find_by_id(params[:pet][:owner_id])
    elsif !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner])
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
    @pet = Pet.find_by_id(params[:id])
    @pet.update(name: params[:pet][:name])
    if params[:owner][:name] != ""
      @owner = Owner.create(params[:owner])
    elsif params[:pet][:owner_id] != nil
      @owner = Owner.find_by_id(params[:pet][:owner_id])
    end
    @pet.save
    @owner.pets << @pet
    @owner.save

    redirect to "pets/#{@pet.id}"
  end
end
