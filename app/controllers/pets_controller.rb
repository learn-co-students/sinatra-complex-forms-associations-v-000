class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet][:name]) # owner: Owner.find(params[:pet][:owner_ids][]))
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
     else
       @pet.owner = Owner.find(params[:pet][:owner_ids][-1])
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

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      @pet.owner = Owner.find(params[:pet][:owner_ids][-1])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
