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
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id]) #retreive the requested pet from the db and make a new instance of it
    if !params[:pet][:name].empty? #if the params[:pet][:name] has something in it,
    @pet.name = (params[:pet][:name]) #set the pet instance's name to that value
    end
    if !params[:owner][:name].empty? #if the params[:owner][:name] has a value in it,
      @new_owner = Owner.find_by name: params[:owner][:name] #retrieve that owner from the database and save in instance variable
      @pet.owner = @new_owner #make the association
    end
    if !params[:owner_name].empty? # if the params[:owner_name] field is filled
      @new_owner = Owner.create(name: params[:owner_name]) #a new owner is created with the params[:owner_name] value
      @pet.owner = @new_owner #make the association
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

end
