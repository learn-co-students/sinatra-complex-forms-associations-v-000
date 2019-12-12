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
    
    if params[:owner_name] == ""
     owner_object = Owner.find_by(id: params[:owner][:id])
   else
     owner_object = Owner.create(name: params[:owner_name])
   end

   @pet = Pet.create(name: params[:pet_name], owner: owner_object)

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])

    @pet.update(name: params[:pet_name])

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      @pet.owner = Owner.find_by(id: params[:owner_id])
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
  
end