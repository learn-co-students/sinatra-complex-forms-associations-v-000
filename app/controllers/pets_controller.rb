class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do

  #  binding.pry
  @pet = Pet.create(params[:pet])
  #binding.pry
  if !params[:owner_name].empty?
    @pet.owner = Owner.create(name: params[:owner_name])

  @pet = Pet.create(params[:pet])
  binding.pry
  if !params["owner"]["name"].empty?
    @pet.owner << Owner.create(name: params["owner"]["name"])
  end
  @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

@pet = Pet.find(params[:id])
#binding.pry
@pet.update(params[:pet])
#binding.pry
if !params[:owner][:name].empty?
  #binding.pry
  @pet.owner = Owner.create(name: params[:owner][:name])
end
@pet.save
    redirect to "pets/#{@pet.id}"
  end

  get "/pets/:id/edit" do
    @pet = Pet.find(params[:id])
    erb :"/pets/edit"
  end



    redirect to "pets/#{@pet.id}"
  end
end
