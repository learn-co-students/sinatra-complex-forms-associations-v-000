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
    owner = Owner.new(params[:owner])
    if !params[:pet][:name].empty?
      owner.pets.build(name: params[:pet][:name])
    end
    owner.save ? redirect("/owners/#{owner.id}") : "Failure"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    #removes the association
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end

    owner = Owner.find(params[:id])
    owner.update(params[:owner])

    if !params[:pet][:name].empty?
      owner.pets.build(name: params[:pet][:name])
    end
    owner.save ? redirect("/owners/#{owner.id}") : "Failure"

  end
end