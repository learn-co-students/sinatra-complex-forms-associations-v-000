require 'pry'

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do #renders new
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet]) #instantiate a new pet
    #binding.pry
    if !params[:owner][:name].empty? #params[:owner][:name].present?
      new_owner = Owner.create(name: params[:owner][:name])
      @pet.owner = new_owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    #binding.pry
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do

    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  patch '/pets/:id' do #edit
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty? #access name in the params owner hash
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
