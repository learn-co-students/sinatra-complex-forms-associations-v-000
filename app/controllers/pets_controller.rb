class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @pets = Pet.all
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    binding.pry
    if !params[:pet][:owner_id].empty?
      @pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id].join)
    else
      @owner = Owner.create(name: params[:owner_name])
      @pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id].join)
    end
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end

end
