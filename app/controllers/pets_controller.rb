class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 

    @pet = Pet.new(name: params[:pet][:name])

    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
   
    else
       @pet.owner = Owner.find(params[:pet][:owner_id][0])
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

    erb :'/pets/edit'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])

    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @pet.update(name: params[:pet][:name], owner_id: @owner.id) 
      @pet.save
    else
      binding.pry
       @pet.update(name: params[:pet][:name])

       @pet.owner = Owner.find(params[:pet][:owner_id].last)
       @pet.save
    end




    redirect "pets/#{@pet.id}"
  end
end