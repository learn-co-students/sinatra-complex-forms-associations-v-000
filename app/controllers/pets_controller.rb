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
    @pet = Pet.create(:name => params[:pet][:name])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(:name => params[:owner][:name])
    else
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  patch '/pets/:id' do

    @pet = Pet.find(params[:id])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(:name => params[:owner][:name])
    else
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end
    if !params[:pet][:name].empty?
      @pet.name = params[:pet][:name]
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

end
