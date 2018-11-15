class PetsController < ApplicationController

  get '/pets' do
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    Pet.create(params[:pet])
    Owner.create(name: params[:owner_name]).pets << newest_pet unless params[:owner_name].empty?
    redirect to "pets/#{newest_pet.id}"
  end

  get '/pets/:id' do
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    current_pet.update(params[:pet])
    Owner.create(name: params[:owner][:name]).pets << current_pet unless params[:owner][:name].empty?
    redirect to "pets/#{current_pet.id}"
  end
end
