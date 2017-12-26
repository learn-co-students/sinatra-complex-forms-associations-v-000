class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners=Owner.all
    #binding.pry
    erb :'/pets/new'
  end

  post '/pets' do
    #binding.pry
    puts params
    @pet=Pet.create(params[:pet])
    #@pet.owner=Owner.find(:owner)
    @pet.owner=Owner.create(name: params["owner"]["name"]) if !params["owner"]["name"].empty?
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
      if !params["owner"]["name"].empty?
        @pet.owner = Owner.create(name: params["owner"]["name"])
      end
      @pet.save
      redirect "/pets/#{@pet.id}"
    end
end
