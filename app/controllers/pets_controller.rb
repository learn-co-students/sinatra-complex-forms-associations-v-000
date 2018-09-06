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
    @pet = Pet.new(name: params[:pet_name])
    if params[:owner_id] && !params[:owner_id].empty?
      @pet.owner_id = Owner.find(params[:owner_id]).id
    end
    if !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
      @pet.owner_id = owner.id
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    if params[:owner_id] && !params[:owner_id].empty?
      @pet.update(owner_id: params[:owner_id])
    end
    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      @pet.update(owner_id: owner.id)
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
end
