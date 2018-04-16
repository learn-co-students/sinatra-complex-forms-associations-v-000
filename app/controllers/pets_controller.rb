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
    @pet = Pet.create(:name => params[:pet_name])
    if !params["owner"]["name"].empty?
      new_owner = Owner.create(:name => params["owner"]["name"])
      new_owner.save
      @pet.owner = new_owner
    elsif !params["pet"]["owner_ids"].empty?
        @pet.owner = Owner.find_by_id(params["pet"]["owner_ids"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    #binding.pry
    @pet = Pet.find_by_id(params[:id])
    @pet.update(:name => params["pet_name"])
    if !params["owner"]["name"].empty?
      new_owner = Owner.create(:name => params["owner"]["name"])
      new_owner.save
      @pet.owner = new_owner
      @pet.save
    elsif !params["pet"]["owner_ids"].empty?
      #binding.pry
      @pet.owner = Owner.find_by_id(params["pet"]["owner_ids"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
#pet[owner_ids][]
