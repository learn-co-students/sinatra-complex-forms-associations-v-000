class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    else 
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id].last)  
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end  

  post '/pets/:id' do
    # binding.pry
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])
    
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    else
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id].last)
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end




# {"pet"=>{"name"=>"Chewie Darling", "owner_id"=>["1"]},
# "owner"=>{"name"=>""},
# "splat"=>[],
# "captures"=>["1"],
# "id"=>"1"}