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
    @pet.owner = Owner.new(name: params[:owner][:name]) unless params[:owner][:name].empty?
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all

    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])
    @pet.owner = Owner.new(name: params[:owner][:name]) unless params[:owner][:name].empty?
    @pet.save
    
    redirect "/pets/#{@pet.id}"
  end
end
