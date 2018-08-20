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

    @pet = Pet.create(name: params[:pet_name])

    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @owner.pets << @pet
      @pet.owner_id = @owner.id
      @owner.save
    else
      @pet.owner_id = params[:owner_id]
    end
    @pet.save

    redirect to "/pets/#{@pet.id}"
  end
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  use Rack::MethodOverride
  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])

    @pet.update(name: params[:pet_name])
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @owner.pets << @pet
      @pet.owner_id = @owner.id
      @owner.save
    else
      @pet.update(owner_id: params[:owner_id])
    end
    redirect to "pets/#{@pet.id}"
  end
end