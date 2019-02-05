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
    @pet = Pet.new(params[:pet])
    @owner = Owner.find_or_create(name: params[:owner][:name])
    @pet.owner = @owner
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.owner = Owner.find_or_create(params[:owner])
    @pet.name = params[:pet][:name]
    @pet.save
    @owners = Owner.all
    redirect to "pets/#{@pet.id}"
  end
end