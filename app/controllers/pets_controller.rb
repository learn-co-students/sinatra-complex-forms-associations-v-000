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
    # binding.pry
    if !!params[:owner][:id]
      @owner = Owner.find_by(params[:owner][:id])
    else
      @owner = Owner.new(params[:owner])
    end
    @owner.pets << @pet
    @owner.save
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
    @pet = Pet.find_by(params[:id])
    @pet.update(params[:pet])
    # @owner = Owner.find_by(id: params[owner])
    binding.pry
    if params[:owner][:name] != ""
      @owner = Owner.new(name: params[:owner][:name])
    else @pet.owner.name != params[:owner][:name]
      @owner = Owner.find_by(id: params[:owner][:id])
    end
    @owner.pets << @pet
    @owner.save

    redirect to "pets/#{@pet.id}"
  end
end
