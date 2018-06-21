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
      if params[:pet] == nil
      @pet = Pet.create(name: params[:pet_name])
      if !params["owner_name"].empty?
            @new_owner = Owner.create(name: params[:owner_name])
            @new_owner.pets << @pet
      end
    else
      @pet = Pet.create(name: params[:pet_name], owner_id: params[:pet][:owner_id])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find_by_id(@pet.owner_id)
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.update(name: params[:pet_name], owner_id: params[:pet][:owner_id])
    @pet.save
      if !params["owner_name"].empty?
        @new_owner = Owner.create(name: params["owner_name"])
        @new_owner.pets << @pet
      end

    redirect to "pets/#{@pet.id}"
  end
end
