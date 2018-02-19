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
    @pet = Pet.create(name: params[:pet][:name])
    if !params[:pet][:owner_id].nil?
      @pet.owner_id = params[:pet][:owner_id]
    elsif !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
      @pet.owner_id = owner.id
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

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      @pet.update(owner_id: owner.id)
    elsif !params[:pet][:owner_id].nil?
      @pet.update(owner_id: params[:pet][:owner_id])
    end
    redirect to "pets/#{@pet.id}"
  end
end
