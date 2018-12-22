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
    @pet = Pet.create(:name => params[:pet][:name])
    if !params[:pet][:owner].empty?
      @pet.owner = Owner.create(params[:pet][:owner])
    end
    redirect to "pets/#{@pet.id}"
  end

  patch '/pets/:id' do
    ####### bug fix
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
    #######
    @pet = Pet.find(params[:id])
    if !params[:pet][:owner].empty?
      @pet.owner = Owner.create(params[:pet][:owner])
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

end
