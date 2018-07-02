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
    @pet = Pet.create(name: params[:name])

    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    else
      @owner = Owner.find(params['owner_id'])
      @pet.owner = @owner
    end

    @pet.save
    redirect "pets/#{@pet.id}"
  end


  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end


  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find_by_id(params[:id])

    erb :'pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])

    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    else
      @owner = Owner.find(params['owner_id'])
      @pet.owner = @owner
    end
    @pet.name = params[:pet_name]
    @pet.save
    # binding.pry

    redirect to "pets/#{@pet.id}"
  end
end
