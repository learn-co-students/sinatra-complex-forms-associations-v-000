require "pry"
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
    @pet = Pet.create(params[:pet])
    #if !params["owner_id"].empty?
    #  @owner = Owner.find(params["owner_id"])
    #  @pet.owner = @owner #activerecord requires explicit saving.
    #  @pet.save
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
      @owner.save
      @pet.owner = @owner
      @pet.save
      @owner.pets << @pet
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    #tour guide helped me 5 hours worth of data
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    ##### bug fix
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
    #####

    @pet = Pet.find(params[:id])
    binding.pry
    @pet.update(name: params[:pet_name])
    if !params["owner"]["name"].empty?
      @pet.owner << Owner.create(name: params["owner"]["name"])
    end
    redirect to "pets/#{@pet.id}"
  end
end
