class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

	get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets' do 
		
		if params["owner"]["name"].empty?
			@pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id].first)
		else
			@pet = Pet.create(name: params[:pet][:name]) 
			@pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
		@pet = Pet.find(params[:id])

		if params["owner"]["name"].empty?
			@pet.name = params[:pet][:name]
			@pet.owner = Owner.find(params[:pet][:owner_id])
		else
			@pet.name = params[:pet][:name]
			@pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save
		
    redirect to "pets/#{@pet.id}"
  end
end
