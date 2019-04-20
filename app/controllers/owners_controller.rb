require 'pry'

class OwnersController < ApplicationController

  get '/owners' do #view all owners
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do #render create new owner page
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    @owner = Owner.create(params[:name])
    @pet = Pet.create(params[:name])
    binding.pry
    @pet.owner = @owner
    @pet.save
    redirect to
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do

  end
end
