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
    @owner = Owner.create(params[:owner])
    @pet = Pet.create(params[:pet])
    @owner.pets << @pet
      redirect "owners/#{@owner.id}"
      # create a pet and add it to owner's pets

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
     if !params["pet"]["name"].empty?
       @owner.pets << Pet.create(name: params["pet"]["name"])
     end
     redirect to "owners/#{@owner.id}"
  end
end
