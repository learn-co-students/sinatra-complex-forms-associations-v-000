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
    if params[:owner][:name].empty?
      @owner = Owner.find_by(id: params[:owner][:owner_id])
    else
      @owner = Owner.create(name: params[:owner][:name])
    end
    @pet = Pet.create(name: params[:pet_name]) if !params[:pet_name].empty?
    @owner.pets << @pet
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])
    @pet.update(params[:pet])
    if params[:owner][:name].empty?
      @owner = Owner.find_by(id: params[:owner][:id])
    else
      @owner = Owner.create(name: params[:owner][:name])
    end
    @pet.owner_id = @owner.id
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end