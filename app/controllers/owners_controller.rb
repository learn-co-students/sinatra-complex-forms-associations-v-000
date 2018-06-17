class OwnersController < ApplicationController

  get '/owners' do #index page that shows all the owners
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do #renders page of a form to submit a new owner
    @pets = Pet.all #get all of the pets to iterate in views/owners/new.erb

    erb :'/owners/new'
  end

  post '/owners' do #creates new instance of owner
    #binding.pry
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do #edits a specific instance of owner
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do #shows a specific owner
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  post '/owners/:id' do
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect "/owners/#{@owner.id}"
  end
end
