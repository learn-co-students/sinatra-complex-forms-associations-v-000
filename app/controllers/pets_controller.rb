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
    if validate_pet(params).is_a?(Pet)
      @pet = validate_pet(params)
      @pet.save
      redirect to "pets/#{@pet.id}"
    else
      @error = validate_pet(params)
      @owners = Owner.all
      erb :'/pets/new'
    end
    # binding.pry
    
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get "/pets/:id/edit" do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :"/pets/edit"
  end

  post '/pets/:id' do 
    if validate_pet(params).is_a?(Pet)
      @pet = validate_pet(params)
      @pet.save
      redirect "/pets/#{@pet.id}"
    else
      @error = validate_pet(params)
      @owners = Owner.all
      @pet = Pet.find(params[:id])
      erb :"/pets/edit"
    end
    redirect to "pets/#{@pet.id}"
  end
  
  helpers do 
    def validate_pet(args)
      if args[:pet][:name]
        @pet = Pet.new(name: args[:pet][:name])
      else
        return "Every pet must have a name."
      end
      if args[:pet][:owner_id] && args[:owner][:name] && !args[:owner][:name].empty? || args[:pet][:owner_id] && args[:pet][:owner_id].length > 1
        return "Please give the pet one owner"
      end
      if args[:pet][:owner_id] && args[:pet][:owner_id].length == 1
        @pet.owner_id = args[:pet][:owner_id].first
      end
      if args[:owner][:name] && !args[:owner][:name].empty?
        owner = Owner.new(name: args[:owner][:name])
        if Owner.find_by(name: args[:owner][:name])
          owner = Owner.find_by(name: args[:owner][:name])
        else
          owner.save
        end  
        @pet.owner_id = owner.id
      end
      @pet
    end
  end
end