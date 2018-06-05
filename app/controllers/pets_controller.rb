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
    @pet = Pet.find_by_id(params[:id])
    @pet = Pet.create(params[:pet])
    if params[:owner][:name] != ""
      owner = Owner.create(params[:owner])
      @pet.owner_id = owner.id
      @pet.save
    else
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
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])
    if params[:owner][:name] != ""
      owner = Owner.create(params[:owner])
      @pet.owner_id = owner.id
      @pet.save
    else
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
