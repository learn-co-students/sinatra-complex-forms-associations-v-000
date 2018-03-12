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
    if params[:owner][:name].empty?
      @pet.owner = Owner.find(params[:owner][:id].to_i)
      @pet.save
    else
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
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
    @pet = Pet.find(params[:id].to_i)
    if params[:owner][:name].empty?
      @pet.update(params[:pet])
      @pet.save
    else
      @pet.owner = Owner.create(params[:owner])
      @pet.save
      ##binding.pry
    end
    redirect to "pets/#{@pet.id}"
  end
end
