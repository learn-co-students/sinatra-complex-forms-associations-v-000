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
    # Note: I don't think this accounts for owners with NO pets at all.
    
    if !params[:pet][:name].empty?
      owner.pets << Pet.create(name: params[:pet][:name])
    end
    # owner.pets << Pet.create(name: params[:pet][:name]) unless params[:pet][:name].blank?
    # I also thought about making a new pet, then setting its owner to the owner variable, but that would create extra code just to do the same thing as above.
    # It may also work just to say Pet.create(params[:pet])
    
    redirect to "/owners/#{owner.id}"
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

  patch '/owners/:id' do 
    ####### bug fix that removes ALL previous pets from the owner
    if !params[:owner].keys.include?("pet_ids") # or, if !params[:owner][:pet_ids]
      params[:owner][:pet_ids] = []
    end 
    #######
    
    owner = Owner.find(params[:id])
    owner.update(params[:owner])
    
    if !params[:pet][:name].empty?
      owner.pets << Pet.create(name: params[:pet][:name])
      # See "post '/owners'" for more comments and ideas
    end
    
    redirect to "/owners/#{owner.id}"
  end
end