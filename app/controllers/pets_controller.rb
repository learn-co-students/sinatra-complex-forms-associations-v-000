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
      if !params["owner_name"].empty?
          if Owner.find_by(name: params["owner_name"])
              @pet.owner_id = Owner.find_by(name: params["owner_name"])
          else
              @pet.owner_id = Owner.create(name: params["owner_name"]).id
          end
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
      @pet.update(params[:pet])
      if !params["owner"]["name"].empty?
          if Owner.find_by(name: params["owner"]["name"])
              @pet.owner_id = Owner.find_by(name: params["owner"]["name"])
              @pet.save
          else
              @pet.owner_id = Owner.create(params[:owner]).id
              @pet.save
          end
      end
    redirect to "pets/#{@pet.id}"
  end
end
