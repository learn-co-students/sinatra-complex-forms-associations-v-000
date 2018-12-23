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
    @pet = Pet.create(:name => params[:pet_name], :owner_id => "")
    if params.length>3
      @pet.owner_id = params.keys[1]
      @pet.save
    end
    if !params[:owner_name].empty?
      @new_owner = Owner.create(name: params[:owner_name])
      @pet.owner_id = @new_owner.id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    binding.pry
    if params[:pet_name] != ""
      @pet.update(:name => params[:pet_name])
    end
    if params.length>5
      @pet.owner_id = params.keys[2]
      @pet.save
    end
    if !params[:owner]["name"].empty?
      @new_owner = Owner.create(name: params[:owner]["name"])
      @pet.owner_id = @new_owner.id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
