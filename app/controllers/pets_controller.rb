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
    if !params[:owner_name].empty?
      @owner = Owner.create(name:params[:owner_name])
      @pet = Pet.create(name:params[:pet_name], owner_id:@owner.id)
    elsif params[:owner_name].empty?
      @pet = Pet.create(name:params[:pet_name], owner_id:params[:owner_id])
    end
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
    @pet = Pet.find(params[:id])

    if !params[:owner_name].empty?
      @owner = Owner.create(name:params[:owner_name])
      @pet.update(name:params[:pet_name], owner_id:@owner.id)
    elsif params[:owner_name].empty?
      @pet.update(name:params[:pet_name], owner_id:params[:owner_id])
    end

    redirect to "pets/#{@pet.id}"
  end
end
