class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    #if you want to display existing pet data in view you will first need to access and store all
    #pet data for a user
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    @owner = Owner.create(params[:owner]) #create new owner instance based on params keys set by form
    if !params[:pet][:name].empty? #if the owner is already associated with a pet(s) in bd
      @owner.pets << Pet.create(name: params[:pet][:name]) #create a pet instance and add it to owner object
    end
    @owner.save #save owner object; this captures the changes
    redirect "/owners/#{@owner.id}" #redirect to that owner's show page
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id]) #find the owner
    @pets = Pet.all #since you want to display pets in form on edit page
    erb :'/owners/edit' #render the page with the edit form
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id]) #find owner
    erb :'/owners/show'
  end

  post '/owners/:id' do
    @owner = Owner.find_by_id(params[:id]) #find owner
    @owner.update(params[:owner]) #update with params data set in form
    if !params[:pet][:name].empty? #if the owner is already associated with a pet(s) in bd
      @owner.pets << Pet.create(name: params[:pet][:name]) #create a pet instance and add it to owner object
    end
    redirect "/owners/#{@owner.id}" #redirect to that owner's show page
  end
end
