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
    #form for creating a new owner and possible pet.
    @owner = Owner.create(params[:owner])
    if !params[:pet][:name].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    #binding.pry
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect "/owners/#{@owner.id}"
    # patch for updating owners and also needs a form.
  end
end
