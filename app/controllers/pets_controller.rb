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
        # binding.pry
       @pet = Pet.create(:name => params['pet']['name'])
       if !params['pet'][:owner_id].empty?
           @owner = Owner.find(params['pet']['owner_id'])
           @pet.owner = @owner
       end
    #    binding.pry
       if !params['pet'][:owner_name].empty?
        #    binding.pry
           @new_owner = Owner.create(:name => params['pet']['owner_name'])
           binding.pry
           @pet.owner = @new_owner
       end
        #  binding.pry
       @pet.save
       redirect "pets/#{@pet.id}"

  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
     @pet = Pet.find(params[:id])
    redirect "pets/#{@pet.id}"
  end
end
