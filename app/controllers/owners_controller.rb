require 'pry'

class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  # ----- CREATE -----

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    owner = Owner.create(params[:owner])

    if !params[:pet][:name].empty?
      owner.pets.create(params[:pet])
    end

    owner.save
    redirect to "owners/#{owner.id}"
  end

  # ----- READ -----

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  # ----- UPDATE -----
  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  post '/owners/:id' do
    owner = Owner.find(params[:id])

    if !params[:owner].has_key?("pet_ids")
      owner.pets.clear
    end

    owner.update(params[:owner])

    if !params[:pet][:name].empty?
      owner.pets.create(params[:pet])
    end

    owner.save
    redirect to "owners/#{owner.id}"
  end
end
