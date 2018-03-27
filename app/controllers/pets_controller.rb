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
    @pet = Pet.new(name: params[:name])
    if @owner = Owner.find_by_id(params[:owner_id])
      @pet.owner_id = @owner.id
    else
      @pet.owner = Owner.create(name: params[:owner_name])
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])

    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name], owner_id: params[:owner_id])
    # => {"pet_name"=>"Chewie Darling", "owner_id"=>"1", "owner"=>{"name"=>""}

    if !params[:owner][:name].empty?
     @pet.owner = Owner.create(name: params[:owner][:name])
   else
     @pet.owner = Owner.find_by_id(params[:owner_id])
   end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
