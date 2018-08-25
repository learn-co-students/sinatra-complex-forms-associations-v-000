class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    # added
    @pets = Pet.all
  # end of add
    erb :'/owners/new'
  end

  post '/owners' do
  # added
    @owner = Owner.create(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets.build(name: params["pet"]["name"])
    end
    @owner.save
    redirect "owners/#{@owner.id}"
    # end of add
  end

  get '/owners/:id/edit' do
    # added
    @pets = Pet.all
    # end of add
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  # patch '/owners/:id' do
  # added
  post '/owners/:id' do
    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets.build(name: params["pet"]["name"])
    end
    @owner.save
    redirect "owners/#{@owner.id}"
# end of add
  end
end
