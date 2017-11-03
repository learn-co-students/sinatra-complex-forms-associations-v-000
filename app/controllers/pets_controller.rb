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

     @pet = Pet.new(name: params[:pet_name])

     if !params["owner_name"].empty?
       @pet.owner = Owner.create(name: params["owner_name"])
     elsif ! params[:pet][:owner_id].empty?
       @pet.owner = Owner.find_by(params["owner_id"])
     end

    @pet.save
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pets = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  post '/pets/:id' do
  @pet = Pet.find(params[:id])

  @pet.update(params["pet"])
   if !params["owner"]["name"].empty?
     @pet.owner = Owner.create(name: params["owner"]["name"])
   end
  # if !params["owner_name"].empty?
  #   @pet.owner = Owner.create(name: params["owner_name"])
  # # elsif !params[:pet].empty?
  # #   @pet.owner = Owner.find_by(params["owner_id"])
  # end
@pet.save
  # if !params["owner_name"].empty?
  #     owner = Owner.create(name: params["owner_name"])
  #     @pet.update(owner: owner)
  # elsif !params[:pet].empty?
  #     owner = Owner.find_by(id: params[:pet][:owner_id])
  #     @pet.update(owner: owner)
  # end

    redirect to "pets/#{@pet.id}"
  end
end
