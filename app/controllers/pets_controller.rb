class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners =  Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    binding.pry
      @pet = Pet.create(params)
      if !params["pet"]["name"].empty?
        @owner = Owner.find_or_create_by(id: params[:pet][:owner_id])
        @pet.owner = @owner
      end

      @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
