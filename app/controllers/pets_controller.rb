class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    params.delete(:captures)
    owner_id = params[:pet][:owner_id]
    if owner_id
      @owner = Owner.find(owner_id)
    else
      @owner = Owner.create(name: params[:owner_name])
    end
    @pet = Pet.create(params[:pet])
    @pet.owner = @owner
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
