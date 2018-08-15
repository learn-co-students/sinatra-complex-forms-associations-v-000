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
    owner = Owner.create(params[:owner])
    if ((new_pet = Pet.new(params[:pet])) && (new_pet.save)) 
      owner.pets << new_pet
    end
    redirect "owners/#{owner.id}"
  end

  get '/owners/:id/edit' do 
    @pets = Pet.all
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  post '/owners/:id' do 
   owner = Owner.find(params[:id])
   owner.update(params[:owner])
   owner.pets << @pet if ((@pet = Pet.new(params[:pet])) && (@pet.save))
   owner.save
   redirect "/owners/#{params[:id]}"
  end
end