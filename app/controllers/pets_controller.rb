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
    if !params[:pet][:owner_id].nil?
      @pet = Pet.new(name: params[:pet][:name],
                owner_id: params[:pet][:owner_id][0].to_i
            )
    else
      owner = Owner.create(name: params[:owner][:name])
      @pet = Pet.new(name: params[:pet][:name])
      @pet.owner = owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get 'pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
