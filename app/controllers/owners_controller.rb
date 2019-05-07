require 'pry'

class OwnersController < ApplicationController

  get '/owners' do #view all owners
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do #render create new owner page
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    @owner = Owner.create(params[:owner]) #creates a new owner
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do #retrieve owner by ID
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end

    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end
end
