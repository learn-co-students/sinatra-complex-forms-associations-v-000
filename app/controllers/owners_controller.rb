class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

#send form
  get '/owners/new' do
  erb :'owners/new'
end

#receive data from form
  post '/owners' do 
   @owner = Owner.create(params[:owner]) #name="owner[name]" 
   if !params["pet"]["name"].empty? #makes sure that the form field was filled out. 
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect "owners/#{@owner.id}"

  end

# send form to edit
  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

 #show the result of editing 
   get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

#receive data from the form 
  post '/owners/:id' do 
    @owner = Owner.find(params[:id])
     @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "owners/#{@owner.id}"
  end

end