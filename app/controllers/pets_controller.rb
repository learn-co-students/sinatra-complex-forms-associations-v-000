class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  post '/pets' do 
    @pet = Pet.find_or_create_by(name: params[:pet][:name])
    new_owner = Owner.find_or_create_by(name: params[:owner_name]) if !params[:owner_name].empty?
    
    if new_owner
      @pet.owner = new_owner
    else
      @pet.owner = Owner.find(params[:pet][:owner_id][0])
    end

    @pet.save
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])
    new_owner = Owner.find_or_create_by(name: params[:owner][:name]) if !params[:owner][:name].empty?
    
    if new_owner
      @pet.update(owner_id: new_owner.id)
    else
      @pet.update(owner_id: Owner.find(params[:pet][:owner_id]).id )
    end

    @pet.save
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end  

end