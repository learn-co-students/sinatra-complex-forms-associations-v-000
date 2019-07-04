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
#  binding.pry
    @pet = Pet.create(params[:pet])
#supposing 1 pet only 1 owner.

     if !params["owner"]["name"].empty?
        @pet.owner= Owner.create(name: params["owner"]["name"])
        @pet.save
     end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    # binding.pry
    @pet = Pet.find(params[:id])
  #  @pets = @owner.pets
    @owners = Owner.all

    erb :'/pets/edit'
  end



  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    #  binding.pry
      @pet = Pet.find(params[:id])
      @pet.update(params["pet"])

      if !params["owner"]["name"].empty?
        @pet.owner = Owner.create(name: params["owner"]["name"])
        @pet.save
      end


    redirect to "pets/#{@pet.id}"
  end
end
