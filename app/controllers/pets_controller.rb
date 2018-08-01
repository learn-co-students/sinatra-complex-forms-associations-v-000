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

    if !params[:owner][:name].empty?

    @owner = Owner.create(name: params[:owner][:name])

    @pet = Pet.create(name: params[:pet][:name], owner_id: @owner.id)

    redirect to "pets/#{@pet.id}"
    else
    @pet = Pet.create(name: params[:pet][:name], owner_id: params[:owner_id])

    redirect to "pets/#{@pet.id}"
    end
  end



  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    #binding.pry
    @pet = Pet.find(params[:id])
  #  if params["pet_name"] != @pet.name
  #    @pet.update(name: params[:pet_name])
  #  end
  #  if params[:owner][:name] != @pet.owner.name

  #    @pet.update(name: params[:owner][:name])
  #  end
  #  if params[:owner_id] != @pet.owner_id
  #  @pet.update(name: params[:owner_id])
 @pet.update(params[:pet])
 if !params[:owner][:name].empty?
   @pet.owner = Owner.create(name: params[:owner][:name])

 #binding.pry

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
