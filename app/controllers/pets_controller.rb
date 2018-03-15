class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
     # @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
     @pet = Pet.create(params[:pet])
     if params[:owner][:name].empty?
        @owner = Owner.find_by_id(params[:owner][:id])
        @owner.pets << @pet
        @owner.save
     else
        @owner = Owner.create(params[:owner])
        @owner.pets << @pet
        @owner.save
     end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    # binding.pry
    erb :'/pets/show'
  end

  post '/pets/:id' do
       # binding.pry
       @pet = Pet.find(params[:id])
       @pet.update(params["pet"])
       if !params["owner"]["name"].empty?
         @pet.owner = Owner.create(name: params["owner"]["name"])
      elsif !params["pet"]["owner_id"].empty?
         @pet.owner = Owner.find_by_id(params["pet"]["owner_id"])
       end
       @pet.save


    redirect to "pets/#{@pet.id}"
  end
end
