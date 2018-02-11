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
    @owner = Owner.create(params[:owner]) #mass assignment: successfully associates new owner with existing pets whose ID numbers were in the params hash
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"]) #create new pet & assign it to this owner
    end
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
    @owner.update(params["owner"]) #mass assignmet to update owner
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "owners/#{@owner.id}"
  end

end