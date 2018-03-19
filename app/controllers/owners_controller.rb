# Owner routing
class OwnersController < ApplicationController
  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    owner = Owner.new(params[:owner])
    owner.pets.new(name: params[:pet][:name]) unless params[:pet][:name].empty?
    owner.save
    redirect "/owners/#{owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  post '/owners/:id' do
    owner = Owner.find(params[:id])
    owner.update(params[:owner])
    pet_name = params[:pet][:name]
    owner.pets.create(name: pet_name) unless pet_name.empty?
    redirect "/owners/#{owner.id}"
  end
end
