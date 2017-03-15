require 'pry'
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
        
        if params[:owner][:owner_id] == nil
            @owner = Owner.create(name: params[:owner][:name])
            @pet.owner = @owner
            
        else
            @pet.owner = Owner.find(params[:owner][:owner_id][0])

        end

        @pet.save
        redirect to "pets/#{@pet.id}"
    end

    get '/pets/:id' do 
        @pet = Pet.find(params[:id])

        erb :'/pets/show'
    end

    post '/pets/:id' do 
        
        @pet = Pet.find(params[:id])
        @pet.update(params[:pet])
        
        new_owner_id = params[:owner][:owner_ids].select do |owner_id|
            @pet.owner != Owner.find(owner_id)
        end
        
        
        if new_owner_id != []
            @pet.owner = Owner.find(new_owner_id[0])
        end
        if !params[:owner][:name].empty?
            
            @owner = Owner.create(name:params[:owner][:name])
            @pet.owner = @owner
        end
            
            
            @pet.save
        
#        binding.pry
        redirect to "pets/#{params[:id]}"
    end
    
    get '/pets/:id/edit' do
        @pet = Pet.find(params[:id])
        erb :'/pets/edit'
    end
end