require 'pry'
class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    erb :'/owners/new'

  end

  post '/owners' do # controller sends you to this route after creating a new owner from the html/erb new page
  @owner = Owner.create(params[:owner])
  if !params["pet"]["name"].empty?
    @owner.pets << Pet.create(name: params["pet"]["name"])
  end
  @owner.save
  redirect to "owners/#{@owner.id}" # the new owner is rendered in this route which is coming from the
  # get '/owners/:id' route that renders the html/erb show page 
end

  get '/owners/:id/edit' do # controller action send you to this route to edit an owner
    @owner = Owner.find(params[:id])
    erb :'/owners/edit' # this html/erb page is rendered
  end

  get '/owners/:id' do  # controller action sends you to this route
    @owner = Owner.find(params[:id])
    erb :'/owners/show' # renders you the pets and owners that were created on the html/erb show page
  end

  post '/owners/:id' do
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "owners/#{@owner.id}" # this html/erb page is rendered after post request is sent to server
  end

end
