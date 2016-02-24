class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    
    @pet=Pet.create(name: params[:pet][:name])
    
    if params[:pet][:owner_ids]
      @owner=Owner.find(params[:pet][:owner_ids].first)
      @owner.pets << @pet

    elsif params[:owner][:name]!=""

      @owner= Owner.create(name: params[:owner][:name]) 
      @owner.pets<<@pet
    end
    @owner.save
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    
    @pet = Pet.find(params[:id])
    @pet.update(name:params[:pet][:name])
    binding.pry
    if !params["owner"]["name"].empty?
      @owner=Owner.create(params["owner"])
      @owner.pets<<@pet
    elsif @owner= Owner.find(params[:pet][:owner_id].first)
      @owner.pets << @pet
    end
    @owner.save
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
end