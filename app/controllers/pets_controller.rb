class PetsController < ApplicationController

   get '/pets' do
      @pets = Pet.all
      erb :'/pets/index'
   end

   get '/pets/new' do
      erb :'/pets/new'
   end

   post '/pets' do
      # binding.pry
      @pet = Pet.create(params[:pet])
      if !params[:owner][:name].empty?
         @pet.owner = Owner.create(name: params[:owner][:name])
         @pet.save
      end
      redirect "/pets/#{@pet.id}"
   end

   get '/pets/:id' do
      @pet = Pet.find(params[:id])
      erb :'/pets/show'
   end

   get '/pets/:id/edit' do
      @pet = Pet.find(params[:id])
      erb :'/pets/edit'
   end

   patch '/pets/:id' do
      # binding.pry
      @pet = Pet.find(params[:id])
      if !params[:pet].keys.include?('owner_id')
         params[:pet][:owner_id] = []
      end
      @pet.update(params[:pet])
      if !params[:owner][:name].empty?
         @pet.owner = Owner.create(name: params[:owner][:name])
         @pet.save
      end
      redirect "/pets/#{@pet.id}"
   end
end
