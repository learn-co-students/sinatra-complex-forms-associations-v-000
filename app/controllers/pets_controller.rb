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
    @pets = Pet.create(params[:pet])
      if !params["owner_name"].empty?
        @pets.owner_id = Owner.create(name: params["owner_name"]).id
      else
        @pets.owner_id = params["owner.name"]
      end
    @pets.save
    redirect to "pets/#{@pets.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    id = @pet.owner_id
    @pet_owner = Owner.find_by(id: id)

    erb :"pets/show"
  end

  post '/pets/:id' do
    @pets = Pet.find(params[:id])
    @pets.update(params["pet"])
    if !params["owner_name"].empty?
      @pets.owner_id = Owner.create(name: params["owner_name"]).id
      @pets.save
    end
    redirect to "/pets/#{@pets.id}"
  end


end
