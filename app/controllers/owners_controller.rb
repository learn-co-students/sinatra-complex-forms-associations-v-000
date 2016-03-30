class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    erb :'/owners/new'
  end

  post '/owners' do 
    @owner = Owner.find_or_create_by(name: params[:owner][:name])
    @owner.pet_ids = params[:owner][:pet_ids]

    new_pet = Pet.find_or_create_by(name: params[:pet][:name]) if !params[:pet][:name].empty?
    @owner.pets << new_pet if new_pet
    @owner.save
    redirect to "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  post '/owners/:id' do 
    @owner = Owner.find(params[:id])
    @owner.name = params[:owner][:name]
    @owner.pet_ids = params[:owner][:pet_ids]
    if !params[:pet][:name].empty?
      new_pet = Pet.find_or_create_by(name: params[:pet][:name]) 
      @owner.pets << new_pet
    end
    @owner.save
    redirect to "/owners/#{@owner.id}"
  end

end