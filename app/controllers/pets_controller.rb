class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if params["owner_name"].empty?
    @pet = Pet.create(:name => params[:pet_name], :owner_id => params["pet"]["owner_id"][0])
    @pet.save
#    @pet.owner_id = params["pet"]["owner_id"]
      else
      @owner = Owner.create(:name => params["owner_name"])
      @pet = Pet.create(:name => params[:pet_name], :owner_id => @owner.id)
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end


  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
  end


    get '/pets/:id/edit' do
      @pet = Pet.find(params[:id])
      @owners = Owner.all

      erb :'/pets/edit'
    end
end
