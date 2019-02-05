require 'pry'
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
      if !params[:owner][:name].empty?
        @pet.owner = Owner.create(name: params[:owner][:name])
        @pet.save
      end
      redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do

@pet = Pet.find_by_id(params[:id])
    @pet.name = params[:pet][:name]
    @pet.save

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    else
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id].flatten)
      @pet.save
    end

      redirect "pets/#{@pet.id}"
  end
end
