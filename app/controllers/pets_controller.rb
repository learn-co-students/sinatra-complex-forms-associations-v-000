class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner_id = Owner.create(name: params["owner"]["name"]).id
    elsif !params["owner"]["owner_ids"].empty?
      @pet.owner_id = params["owner"]["owner_ids"].first
    end
    @pet.save
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
    @pet = Pet.find(params[:id])
    binding.pry if params["owner"]["name"] == "Samantha"
    owner_id = params["owner"]["name"].empty? ? params["pet"]["owner_ids"].first : Owner.create(name: params["owner"]["name"]).id
    @pet.update(name: params["pet"]["name"], owner_id: owner_id)
    redirect to "pets/#{@pet.id}"
  end

end
