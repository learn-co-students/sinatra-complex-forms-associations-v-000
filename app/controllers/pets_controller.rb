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
     if params[:owner][:id] == nil
      @owner = Owner.create(:name => params[:owner][:name])
      @pet = Pet.create(:name=>params["pet"]["name"], :owner_id =>@owner.id)
    else
      @pet = Pet.create(:name=>params["pet"]["name"], :owner_id =>params["owner"]["id"])
    end

     redirect "pets/#{@pet.id}"

  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
     erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
     @pet = Pet.find(params[:pet][:id])
     @pet.name = params[:pet][:name]
     @pet.owner_id = params[:pet][:owner_id]
     @pet.save
   redirect to "pets/#{@pet.id}"
  end




end
