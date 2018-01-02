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
    if !params[:pet][:name].empty?  
			@pet = Pet.find_or_create_by(name: params[:pet][:name])			
	  end
	  
		if !params[:owner][:name].empty?
			@pet.owner = Owner.find_or_create_by(name: params[:owner][:name])
		else
			@pet.owner = Owner.find_by(id: params[:owner][:id])
		end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
      if !params[:owner][:name].empty?
        @pet.owner = Owner.find_or_create_by(name: params[:owner][:name])
        @pet.owner_id = @pet.owner.id
      end
      @pet.save
    redirect to "pets/#{@pet.id}"
  end
end