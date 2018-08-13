class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do
    @pet_name = params[:pet_name]
    if !params[:owner_name].empty?
      @pet = Pet.create(:name => @pet_name)
      owner = Owner.create(:name => params[:owner_name])
      owner.pets << @pet
      @pet.owner_id = owner.id
    else
      @owner = Owner.find(params[:owner_id])
      @pet = Pet.create(:name=>@pet_name, :owner_id => params[:owner_id])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(:name => params[:pet_name])
    if !params[:owner_name].empty?
      @owner = Owner.create(:name => params[:owner_name])
      @owner.pets << @pet
    else
      @pet.update(:owner_id => params['owner']['name'])
    end

    redirect to "pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end
end