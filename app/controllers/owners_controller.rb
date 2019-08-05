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
    
    if !params[:pet][:name].empty?
      owner.pets << Pet.create(name: params[:pet][:name])
    end
    # owner.pets << Pet.create(name: params[:pet][:name]) unless params[:pet][:name].blank?
    # I also thought about making a new pet, then setting its owner to the owner variable, but that would create extra code just to do the same thing as above.
    
    redirect to "/owners/#{owner.id}"
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