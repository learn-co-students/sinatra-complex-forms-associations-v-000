class PetsController < ApplicationController

  get '/pets' do
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    @pet.owner = Owner.create(name: params[:owner_name]) unless params[:owner_name].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    binding.pry
    @pet = Pet.find_by(params[:id])
    @pet.update(params[:pet])
    @pet.owner = Owner.create(name: params[:owner][:name]) unless params[:owner][:name].empty?
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
