class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    #binding.pry
    @pet = Pet.create(params[:pet])

      if !params["owner"]["name"].empty?
        @owner = Owner.create(name: params["owner"]["name"])
        @pet.owner_id = @owner.id
        @owner.save
      else
        @pet.owner_id = params[:pet]["owner_id"][0]
      end
      @pet.save

    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.create(params[:pet])
      #binding.pry
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @owner.id
      @owner.save
    else
      #binding.pry
      @owner = Owner.find_by(name: params["name"])
      @pet.owner_id = @owner.id
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
