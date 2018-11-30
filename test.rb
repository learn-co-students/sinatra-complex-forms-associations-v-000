class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

#in the code below - the form produced a bunch of strange " " and white space punctuation when looking at Owner.all for new records just created
#<Owner id: 1, name: "Sophie">, #<Owner id: 2, name: nil>, #<Owner id: 3, name: "Nora">, #<Owner id: 4, name: nil>, #<Owner id: 5, name: "Jason">,
#<Owner id: 6, name: "{\"name\"=>\"Lorenzo\", \"pet_ids\"=>[\"3\"]}">, #<Owner id: 7, name: "{\"name\"=>\"Lorenzo\", \"pet_ids\"=>[\"3\"]}">, #<Owner id: 8, name: "{\"name\"=>\"Lorenzo\", \"pet_ids\"=>[\"3\"]}">, #<Owner id: 9, name: "{\"name\"=>\"Lorenzo\", \"pet_ids\"=>[\"3\"]}">]>
  post '/owners' do
    @owner=Owner.create(name: params[:owner])
    if !params[:pet][:name].blank?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end
    "made it"
    #redirect 'owners/#{@owner.id}'
  end

#this code below produces the entries in the format of the second line (no spurious " " or \ or [] - why?)
  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    "made it"
    #redirect "owners/#{@owner.id}"
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  get '/owners/:id/edit' do
    puts "nailed it"
    @owner = Owner.find(params[:id])
    #erb :'/owners/edit'
  end

  patch '/owners/:id' do

  end
end
