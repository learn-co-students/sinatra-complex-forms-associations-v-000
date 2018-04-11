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

    if !params[:owner][:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner][:owner_name])
    elsif params[:owner][:owner_name].empty?
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    #binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])

    @pet.update(params[:pet])

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    elsif params[:owner][:name].empty?
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
