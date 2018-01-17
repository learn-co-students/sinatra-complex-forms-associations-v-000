class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owner = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet][:name])

    if !params[:owner][:name].empty?
      #binding.pry
      @owner = Owner.create(name: params[:owner][:name])
      @pet.owner_id = @owner.id
    else
      @pet.owner_id = params[:pet][:owner_id].first
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    #binding.pry
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :"pets/edit"
  end
  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    #binding.pry
    @pet.name = params[:pet][:name]

    #binding.pry
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @pet.owner_id = @owner.id
    else
      @pet.owner_id = params[:owner_id]
    end
    @pet.save
    #binding.pry
    redirect to "pets/#{@pet.id}"
  end

end
