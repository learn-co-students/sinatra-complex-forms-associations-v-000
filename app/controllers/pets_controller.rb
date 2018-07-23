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
    
    if params[:owner_name] == ""
      @owner = Owner.find_by(id: params[:owner_id])
      @pet.owner_id = @owner.id
      @pet.owner = @owner
      @owner.pets << @pet
    else
      binding.pry
      @owner = Owner.create(name: params[:owner_name])
      
    end
    
    
=begin    
    if !params[:owner_id].empty?
      @pet.owner << Owner.create(name: params[:owner_name])
    end
=end
    
    @pet.save
    @owner.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end