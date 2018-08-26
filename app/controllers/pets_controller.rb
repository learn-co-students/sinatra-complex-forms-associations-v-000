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
    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
    else
      @owner = Owner.find_by_id(params[:pet][:owner_ids][0])
      @pet.owner = @owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      # binding.pry
      @owner = Owner.find_by_id(params[:pet][:owner_ids][0])
      @pet.owner = @owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
end