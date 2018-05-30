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
      binding.pry
       @pet = Pet.create(params['pet'])
       @pet.save
       redirect "pets/#{@pet.id}"

  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
     @pet = Pet.find(params[:id])
    redirect "pets/#{@pet.id}"
  end
end
