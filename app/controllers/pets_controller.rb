class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet])
    if params[:owner_name].present?
      @pet.owner = Owner.create(name: params[:owner_name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.new(params[:pet])
    if params[:owner][:name].present?
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
