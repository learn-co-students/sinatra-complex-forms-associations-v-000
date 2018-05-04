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
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    @pet.save
    # binding.pry
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find_by_id(params[:owner_id])
    binding.pry
    erb '/pets/edit'.to_sym
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
# binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["pet"]["name"].empty?
      @pet.owner = Pet.create(name: params["pet"]["name"])
      @pet.save
    end
    redirect "pets/#{@pet.id}"
  end
end
