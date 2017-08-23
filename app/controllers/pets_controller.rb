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
    @pet = Pet.new(params[:pet])

    if !params[:owner][:name].empty?
      @owner = Owner.new(params[:owner])
    else
      @owner = Owner.find(@pet.owner_id)
    end
    @pet.owner = @owner
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])

    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    erb :'pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])

    if !params[:owner][:name].empty?
      @pet.owner= Owner.create(params[:owner])
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
