class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    #binding.pry
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets=Pet.all
    #binding.pry
    erb :'/owners/new'
  end

  post '/owners' do
    #binding.pry
    @owner=Owner.create(params[:owner])
    @owner.pets<<Pet.create(name: params["pet"]["name"]) if !params["pet"]["name"].empty?
    @owner.save
    redirect "owners/#{@owner.id}"

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
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    @owner.pets<<Pet.create(name: params["pet"]["name"]) if !params["pet"]["name"].empty?
    redirect to "owners/#{@owner.id}"

  end
end
