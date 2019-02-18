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
    if params[:owner][:name] != ""
      @pet.update(owner_id: Owner.create(params[:owner]).id)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet][:name]

    if params[:owner][:name] == ""
      @new_owner = Owner.find(params[:pet][:owner_id])
      @pet.owner = @new_owner
      @pet.save
    else
      @pet.update(owner_id: Owner.create(params[:owner]).id)
    end

    redirect to "pets/#{@pet.id}"
  end
end