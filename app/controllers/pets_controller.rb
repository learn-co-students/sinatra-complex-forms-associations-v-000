class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create( params["owner"])
    else
      @owner = Owner.find_by_id(params["pet"]["owner_id"])
      @pet.owner = @owner
    end
    # @owner.save
    @pet.save
    # binding.pry #no hit
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    # binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
# binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create( params["owner"])
    else
      @owner = Owner.find_by(params[:owner][:name])
      # binding.pry
      @pet.owner = @owner
    end
    @pet.update
    @owner.save
    redirect to "pets/#{@pet.id}"
  end
end
