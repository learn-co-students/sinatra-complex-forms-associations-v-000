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
    @pet = Pet.create(params[:pet])
    if !params[:owner_name].empty?
      Owner.find_or_create_by(name: params[:owner_name]).pets << @pet
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id]) 
    @pet.update(params[:pet])
    
    if !params[:owner][:name].empty?
      @pet.update(owner_id: Owner.find_or_create_by(name: params[:owner][:name]).id)
    end

    redirect to "pets/#{@pet.id}"
  end
end