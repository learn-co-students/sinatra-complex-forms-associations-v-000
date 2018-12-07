class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @pets = Pet.all
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:owner_name].empty? #if the user didn't click a checkbox
      @owner = Owner.create(name: params[:owner_name]) #create a new owner using the name the user provided in owner_name field
      @pet.owner = @owner #make the association
    end
    @pet.save #persist to the database
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    # binding.pry
    # binding.pry
    erb :'/pets/edit'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end

end
