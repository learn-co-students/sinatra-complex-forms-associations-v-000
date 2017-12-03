class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet])
    @pet.save
    if params[:owner][:name] != ""
      @pet.owner = Owner.new(params[:owner])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params["id"])
    @pet.update(params["pet"])
    if params["owner"]["name"] != ""
      @owner = Owner.find_by(name: "#{params["owner"]["name"]}")
      if @owner != nil
        @pet.owner_id = @owner.id
      else
        @new_owner = Owner.new(params["owner"])
        @new_owner.save
        @pet.owner_id = @new_owner.id
        @pet.save
      end
    end
    redirect to "pets/#{@pet.id}"
  end
end
