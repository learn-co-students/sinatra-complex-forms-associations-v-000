class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    # @owners = Owner.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do     
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    end   
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end  

  post '/pets/:id' do 
    pet = Pet.find(params[:id])
    pet.update(params["pet"])
    if !params[:owner][:name].empty?
      pet.owner = Owner.create(params[:owner])
      pet.save
    end
    redirect to "pets/#{pet.id}"
  end

  delete '/pets/:id/delete' do
    pet = Pet.find(params[:id])
    pet.delete
    redirect '/pets'
  end 

end  # End of Class