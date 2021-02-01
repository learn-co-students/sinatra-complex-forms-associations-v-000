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
    # binding.pry
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
  @pet.owner = Owner.create(name: params["owner_name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @owner = Owner.all
    # @owner = Owner.find_by_id(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    # binding.pry
    @pet = Pet.find(params[:id])
      @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    ###### bug fix
    if !params[:pet].keys.include?("owner_id")
    params[:pet]["owner_id"] = []
    end
    ######
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params["pet"])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end