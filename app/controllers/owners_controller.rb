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
    # @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
      end
    redirect "owners/#{@owner.id}"
   end


   get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    # if !params[:owner].keys.include?("pet_ids")
    # params[:owner]["pet_ids"] = []
    erb :'/owners/show'
  end


  patch '/owners/:id' do
binding.pry
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
