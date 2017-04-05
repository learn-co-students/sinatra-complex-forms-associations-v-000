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
    pet = Pet.new(params[:pet])
    if !params[:owner][:name].empty?
      owner = Owner.new(params[:owner])
      pet.owner = owner
    end
    pet.save
    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    pet = Pet.find(params[:id])
    pet.update(params[:pet])
    if !params[:owner][:name].empty?
      owner = Owner.new(params[:owner])
      owner.pets << pet
      owner.save
    end
    redirect to "pets/#{pet.id}"
  end

  delete '/pets/:id/delete' do
    @pet = Pet.find(params[:id])
    @pet.delete
    redirect '/pets'
  end

end
