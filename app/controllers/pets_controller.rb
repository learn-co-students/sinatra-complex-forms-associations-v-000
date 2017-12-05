require 'pry'
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet][:name])
    if !params[:owner_name].empty?
	     @owner = Owner.create(name: params[:owner_name])
	     @pet.owner = @owner
    else
        if params[:owners].size > 0
           params[:owners].each do | id |
             @pet.owner = Owner.find_by_id(id)
          end
        end
    end
     @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end


  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.name = params[:pet][:name]
    if !params[:owner][:name].empty?
	     @owner = Owner.create(params[:owner])
	      @pet.owner = @owner
      else
	       @pet.owner = Owner.find_by_id(params[:owners][0])
       end
       @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
