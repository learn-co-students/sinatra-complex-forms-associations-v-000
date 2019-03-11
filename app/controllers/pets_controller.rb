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
    params[:pet][:owner_id] = "" if !params[:pet].keys.include?("owner_id")

    pet = Pet.new(params[:pet])
    if !params[:owner][:name].empty? && params[:pet][:owner_id].empty?
      pet.build_owner(params[:owner])
    end

    pet.save ? redirect("pets/#{pet.id}") : "failure"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :"/pets/edit"
  end

  patch '/pets/:id' do 
    params[:pet][:owner_id] = "" if !params[:pet].keys.include?("owner_id")

    pet = Pet.find(params[:id])
    pet.update(params[:pet])
    if !params[:owner][:name].empty?
      pet.owner = nil
      pet.build_owner(params[:owner])
      pet.save
    end
    redirect to "pets/#{pet.id}"
  end
end