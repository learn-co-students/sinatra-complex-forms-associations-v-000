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
    @pet = Pet.create(name: params[:pet][:name], owner_id: params[:owner_id])
   #binding.pry
     if !params["owner_name"].empty?
       @owner = Owner.create(name: params[:owner_name])
       @pet.owner_id = @owner.id
       @owner.save
     end

     @pet.save
#binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    #binding.pry
    @pet = Pet.find_by_id(params[:id])
  #binding.pry
  @pet.update(params[:pet])
    #@pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])

    end
      @pet.save
    redirect to "pets/#{@pet.id}"
  end

end
