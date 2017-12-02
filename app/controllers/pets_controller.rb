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
    @pet = Pet.create(params[:pet])
      # Eh -- Ignore this -- For line below, note that the field in new.erb is owner_name (had to be that way to pass the test)
      # but this had an effect on params due to whatever method in ActiveRecord/Sinatra, so had to
      # accomodate with the code below.
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])

    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'pets/edit'
  end
  
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    @pet = Pet.find_by_id(params[:id])
    @pet.update(params["pet"])
    # @pet.name = params[:pet][:name]
    # @pet.owner = params[:pet][:owner_id]

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])

    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'pets/edit'
  end
end
