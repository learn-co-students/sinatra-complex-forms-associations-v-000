require 'pry'
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
    @pet = Pet.create(:name => params[:pet_name], :owner_id => "")
    if !params[:owner_id].empty?
      @pet.owner_id = params[:owner_id]
    end
    if !params[:owner_name].empty?
      @new_owner = Owner.create(name: params[:owner_name])
      @pet.owner_id = @new_owner.id
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
