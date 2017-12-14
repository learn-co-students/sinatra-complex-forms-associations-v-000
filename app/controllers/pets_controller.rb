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
      @pet.owner = Owner.create(name: params[:owner][:name])     
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    if !params[:pet][:name].empty?
      @pet.name = params[:pet][:name]
    end
    if !params[:owner][:name].empty?
      @pet.owner = Owner.new(name: params[:owner][:name])
    elsif @pet.owner_id != params[:pet][:owner_id]
      @pet.owner_id = params[:pet][:owner_id]
    end
    # binding.pry
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end
end