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
    @owner.pets << Pet.create(:name => params["pet"]["name"]) unless params["pet"]["name"].empty?
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
    @owner.update(params[:owner])
    @owner.pets << Pet.create(:name => params["pet"]["name"]) unless (params["pet"]["name"].empty? || Pet.all.find_by(:name => params["pet"]["name"]))
    @owner.save
    erb :'/owners/show'
  end
end
