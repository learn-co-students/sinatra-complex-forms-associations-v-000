class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    # @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
#     binding.pry
#     [1] pry(#<PetsController>)> @pet
# => #<Pet:0x000000034ab188 id: 1, name: "Michael", owner_id: nil>
# [2] pry(#<PetsController>)> params
# => {"pet"=>{"name"=>"Michael"},
#  "owner"=>{"name"=>["1"]},
#  "owner_name"=>"",
#  "captures"=>[]}
    if !params["pet"]["owner_name"].empty?
      # @owner.pets << Pet.create(name: params["pet"]["name"])
      @owner.pets << Pet.create(params[:pet])
      binding.pry

      @pet.owner = ["pet"]["owner_name"]
    end
    @owner.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    # binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
