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
       @pet = Pet.create(:name => params[:pet][:name], :owner_id => params[:pet][:owner_id])
       if params[:owner][:name] != ""
         @pet.owner_id = Owner.create(:name => params[:owner][:name]).id
       end

       redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end