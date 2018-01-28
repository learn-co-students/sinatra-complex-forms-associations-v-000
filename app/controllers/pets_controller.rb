class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do #doesnt check for if owner is not selected nor created/ same for post '/pets/:id'
    # binding.pry
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      params[:pet][:owner_id] = @owner.id
    end
    @pet = Pet.create(params[:pet])

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
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      params[:pet][:owner_id] = @owner.id
    end
    
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])

    redirect to "pets/#{@pet.id}"
  end
end