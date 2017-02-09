class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.new(:name => params[:pet][:name])
    create_owners(params, @pet)
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet][:name]
    @pet.owner = nil
    @pet.save
    create_owners(params, @pet)
    redirect to "pets/#{@pet.id}"
  end

  helpers do 
    
    def create_owners(params, pet)
      if params[:owner][:name] != ""
        @pet.create_owner(:name => params[:owner][:name])
        @pet.save
      elsif owner_id = params[:pet][:owner_id]
        owner = Owner.find(owner_id)
        @pet.owner = owner
        @pet.save
      end
    end

  end
end