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
    @pet = nil
    if params["owner_name"].empty?
      @pet = Pet.create(name: params[:pet_name], owner_id: params[:pet][:owner_id])
    else
      new_owner = Owner.create(name: params["owner_name"])
      @pet = Pet.create(name: params[:pet_name], owner_id: new_owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    if params[:owner][:name].empty?
      @pet.update(name: params[:pet_name], owner_id: params[:owner_id])
    else
      new_owner = Owner.create(name: params[:owner][:name])
      @pet.update(name: params[:pet_name], owner_id: new_owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end
end
