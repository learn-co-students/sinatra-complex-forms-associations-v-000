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
 # binding.pry
    @owner = Owner.create(params[:owner])
     if !params["pet"]["name"].empty?
        @owner.pets << Pet.create(name: params["pet"]["name"])
     end
    redirect "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    # binding.pry
    @owner = Owner.find(params[:id])
  #  @pets = @owner.pets
    @pets = Pet.all

    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do

    # binding.pry
    if !params[:owner].keys.include?("pet_ids")  # Use case: when existing pets needed to be remove and add a new one.

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
