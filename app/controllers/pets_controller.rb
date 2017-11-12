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
    if !params[:pet][:owner_id] || !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
    else
      @owner = Owner.find_by_id(params[:pet][:owner_id])
    end
     @owner.pets << @pet
     @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
      @pet = Pet.all.find(params[:id])
      erb :'pets/show'
  end

   get '/pets/:id/edit' do
     @pet = Pet.find_by_id(params[:id])
     @owner = @pet.owner
     erb :'/pets/edit'
   end

   patch '/pets/:id' do
     @pet = Pet.find(params[:id])
     if !params[:owner_name].empty?
       @owner = Owner.create(name:params[:owner_name])
       @pet.update(name:@owner.name, owner_id:@owner.id)
      else
        @pet.update(name:params[:pet_name], owner_id:params[:owner_id])
     end
     @pet.save
     redirect to "pets/#{@pet.id}"
   end

end
