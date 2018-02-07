require 'pry'

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    # raise params.inspect
    @pet = Pet.create(params[:pet])
    if params["owner"]
      @pet.owner = Owner.find(params["owner"])
    elsif !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    elsif params["owner"]
      @pet.owner = Owner.find(params["owner"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
