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
    if params[:pet][:owner_id]
      @pet.owner = Owner.find_by_id(params["pet"]["owner_id"])
    elsif params[:owner][:name] != ""
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if @pet.owner["name"] != params["owner"]["name"]
      @owner = Owner.find_by_name(params["owner"]["name"])
      @owner.pets << @pet
    end
    if params[:owner][:new_owner] != ""
      @owner = Owner.create(:name => params[:owner][:new_owner])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet= Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/edit'
  end
end
