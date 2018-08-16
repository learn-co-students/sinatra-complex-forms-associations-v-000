class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
      new_owner = Owner.create(name: params["owner_name"])
      @pet.owner_id = new_owner.id
    else
      @pet.owner_id = params[:owner][:ids]
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    erb :'pets/edit'
    redirect to "pets/#{@pet.id}"
  end
end
