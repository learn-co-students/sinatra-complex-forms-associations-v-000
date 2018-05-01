class OwnersController < ApplicationController
 # All the owner and pets are loaded automaticly from our data base.

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    # create a new owner
    @owner = Owner.create(params[:owner])

    # control for creating a new pet (if pet and name is empty)
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect to "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

# this is updating
  post '/owners/:id' do
    @owner = Owner.find(params[:id])
    # update effect
    @owner.update(params["owner"])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "owners/#{@owner.id}"
  end
end
