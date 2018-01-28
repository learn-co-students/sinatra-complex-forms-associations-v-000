class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    erb :'/owners/new'
  end

  post '/owners' do 
    @owner = Owner.new(name: params[:owner][:name])
    @owner.save
    create_pets(params, @owner)
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end
  
  post '/owners/:id' do 
    @owner = Owner.find(params[:id])
    @owner.name = params[:owner][:name]
    @owner.pets.clear
    create_pets(params, @owner)
    redirect "/owners/#{@owner.id}"
  end

  helpers do

    def create_pets(params, owner)
      if params[:pet][:name] != ""
        Pet.create(name: params[:pet][:name], owner_id: @owner.id)
      end
      if params[:owner][:pet_ids]

        params[:owner][:pet_ids].each do |pet_id|
          pet = Pet.find(pet_id)
          pet.owner = @owner
          pet.save
          @owner.save
        end
      end
    end
  end
end