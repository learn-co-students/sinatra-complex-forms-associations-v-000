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

    if !params[:owner][:name].empty?
      @pet.owner = Owner.find_or_create_by(params[:owner])
    else
      @pet.owner_id = params[:pet][:owner_id][0]
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
      if !params[:owner][:name].empty?
        @new_owner = Owner.create(params["owner"])
        @pet.owner_id = @new_owner.id
      else
        @pet.owner_id = params[:pet][:owner_id][0].to_i
      end
      @pet.save
    redirect to "pets/#{@pet.id}"
  end
end