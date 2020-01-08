class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do
    @pets = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner << Owner.create(name: params["owner"]["name"])
    end
    redirect to "pet/#{@pet.id}"
  end






  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end