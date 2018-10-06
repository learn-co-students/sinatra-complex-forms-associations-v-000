class PetsController < ApplicationController

  get '/pets' do
    @owners = Owner.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @owners = Owner.all
    @pet = Pet.create(params[:pet])

    if !params[:owner][:name].empty? && !Owner.find_by(params[:pet][:owner_id])
      @pet.owner = Owner.create(params[:owner])
    end
      @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do

    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    @pet.owner_id = params["pet"][:owner_id]
    @pet.save

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    end
      @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
