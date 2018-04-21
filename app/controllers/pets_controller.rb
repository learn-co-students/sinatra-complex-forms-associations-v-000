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
    @pet=Pet.create(params["pet"])
    if !params["owner_name"].empty?
    @pet.owner = Owner.create(name: params["owner_name"])
  else
      @pet.owner = Owner.find_by(params["owner_name"])
      # binding.pry
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
      @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
      # binding.pry
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    # @pet.owner.id = params[:pet][:owner_id]
    # @pet.owner=Owner.find_by(params[:pet][:owner_id])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])

    # else
    #     @pet.owner.name = params["owner"]["name"]
# binding.pry
      end

      @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
