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
    #binding.pry
    if params[:new_owner].empty?
      @pet = Pet.create(params[:pet])
    else
      owner = Owner.create(:name => params[:new_owner])
      @pet = Pet.create(:name => params[:pet][:name], :owner => owner)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    redirect to "pets/#{@pet.id}"
  end
end