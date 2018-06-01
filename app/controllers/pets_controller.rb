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
    #   binding.pry
       @pet = Pet.create(:name => params['pet']['name'])
       if params['pet'][:owner_id] != nil && !params['pet'][:owner_id].empty?
            @owner = Owner.find(params['pet'][:owner_id])
            @pet.owner = @owner
        end
        # binding.pry
        if params['pet'][:owner_name] != nil && !params['pet'][:owner_name].empty?
            @new_owner = Owner.create(:name => params['pet']['owner_name'])
            @pet.owner = @new_owner
        end
       @pet.save
       redirect "pets/#{@pet.id}"

  end

    get '/pets/:id/edit' do
      @pet = Pet.find(params[:id])
      @owners = Owner.all
    #   binding.pry
      erb :'pets/edit'
   end

   post '/pets/:id' do
    #    binding.pry
      @pet = Pet.find(params[:id])
      @pet.update(:name => params['pet_name'])
      if params['owner_name'] != nil && !params['owner_name'].empty?
        #   binding.pry
          @pet.owner.update(:name => params['owner_name'])
      end
      if  params['owner']['name'] != nil && !params['owner']['name'].empty?
          @owner = Owner.find_by(:name => params['owner']['name'])
        #   binding.pry
          @pet.update(:owner_id => @owner.id)
      end
    #   binding.pry
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
