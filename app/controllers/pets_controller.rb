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
    @pet = Pet.create
    @pet.name = params[:pet_name]
    if params[:owner_id]
      @owner = Owner.find_by(params[:owner_id])
      @owner.pets << @pet
    else
      @owner = Owner.create(:name => params[:owner_name])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end


  get '/pets/:id/edit' do

    @pet = Pet.find(params[:id])
    @owners = Owner.all
    binding.pry
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find_by(:id => @pet.owner_id)
    erb :'/pets/show'
  end


  patch '/pets/:id' do
    @pet = Pet.find_by(:id => params[:id])
    @pet.name = params[:pet][:name]
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
